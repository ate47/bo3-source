#using scripts/zm/zm_challenges_tomb;
#using scripts/zm/zm_tomb_amb;
#using scripts/zm/zm_tomb_vo;
#using scripts/zm/zm_tomb_utility;
#using scripts/zm/zm_tomb_magicbox;
#using scripts/zm/zm_tomb_capture_zones_ffotd;
#using scripts/zm/_zm_pack_a_punch;
#using scripts/zm/craftables/_zm_craftables;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_perk_random;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_magicbox;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_attackables;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/math_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace zm_tomb_capture_zones;

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x2d63cbd3, Offset: 0x1328
// Size: 0x31c
function function_5e78485c() {
    zm_tomb_capture_zones_ffotd::function_15112162();
    level.var_44ebf6d = 1;
    function_7f281ae();
    level flag::init("zone_capture_in_progress");
    level flag::init("recapture_event_in_progress");
    level flag::init("capture_zones_init_done");
    level flag::init("recapture_zombies_cleared");
    level flag::init("generator_under_attack");
    level flag::init("all_zones_captured");
    level flag::init("generator_lost_to_recapture_zombies");
    level flag::init("power_on1");
    level flag::init("power_on2");
    level flag::init("power_on3");
    level flag::init("power_on4");
    level flag::init("power_on5");
    level flag::init("power_on6");
    root = generic%root;
    i = generic%p7_fxanim_zm_ori_pack_pc1_anim;
    i = generic%p7_fxanim_zm_ori_pack_pc2_anim;
    i = generic%p7_fxanim_zm_ori_pack_pc3_anim;
    i = generic%p7_fxanim_zm_ori_pack_pc4_anim;
    i = generic%p7_fxanim_zm_ori_pack_pc5_anim;
    i = generic%p7_fxanim_zm_ori_pack_pc6_anim;
    i = generic%p7_fxanim_zm_ori_pack_return_pc1_anim;
    i = generic%p7_fxanim_zm_ori_pack_return_pc2_anim;
    i = generic%p7_fxanim_zm_ori_pack_return_pc3_anim;
    i = generic%p7_fxanim_zm_ori_pack_return_pc4_anim;
    i = generic%p7_fxanim_zm_ori_pack_return_pc5_anim;
    i = generic%p7_fxanim_zm_ori_pack_return_pc6_anim;
    i = generic%p7_fxanim_zm_ori_monolith_inductor_pull_anim;
    i = generic%p7_fxanim_zm_ori_monolith_inductor_pull_idle_anim;
    i = generic%p7_fxanim_zm_ori_monolith_inductor_release_anim;
    i = generic%p7_fxanim_zm_ori_monolith_inductor_shake_anim;
    i = generic%p7_fxanim_zm_ori_monolith_inductor_idle_anim;
    level thread function_61f25547();
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x1650
// Size: 0x4
function function_7f281ae() {
    
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0xe07ca93a, Offset: 0x1660
// Size: 0x88c
function function_61f25547() {
    var_a5da94b9 = getent("capture_zombie_spawner", "targetname");
    var_a5da94b9 spawner::add_spawn_function(&zm_tomb_utility::function_758db58b);
    var_7b4a8f72 = struct::get_array("s_generator", "targetname");
    var_2dc6026c = struct::get_array("generator_attackable", "targetname");
    clientfield::register("world", "packapunch_anim", 21000, 3, "int");
    clientfield::register("actor", "zone_capture_zombie", 21000, 1, "int");
    clientfield::register("scriptmover", "zone_capture_emergence_hole", 21000, 1, "int");
    clientfield::register("world", "zc_change_progress_bar_color", 21000, 1, "int");
    clientfield::register("world", "zone_capture_hud_all_generators_captured", 21000, 1, "int");
    clientfield::register("world", "zone_capture_perk_machine_smoke_fx_always_on", 21000, 1, "int");
    clientfield::register("world", "pap_monolith_ring_shake", 21000, 1, "counter");
    clientfield::register("zbarrier", "pap_emissive_fx", 21000, 1, "int");
    clientfield::register("clientuimodel", "zmInventory.capture_generator_wheel_widget", 21000, 1, "int");
    foreach (struct in var_7b4a8f72) {
        clientfield::register("world", struct.script_noteworthy, 21000, 7, "float");
        clientfield::register("world", "state_" + struct.script_noteworthy, 21000, 3, "int");
        clientfield::register("world", "zone_capture_hud_generator_" + struct.script_int, 21000, 2, "int");
        clientfield::register("world", "zone_capture_monolith_crystal_" + struct.script_int, 21000, 1, "int");
        clientfield::register("world", "zone_capture_perk_machine_smoke_fx_" + struct.script_int, 21000, 1, "int");
    }
    while (!level flag::exists("start_zombie_round_logic")) {
        wait 0.5;
    }
    level flag::wait_till("start_zombie_round_logic");
    objective_add(0, "invisible", (0, 0, 0), istring("zm_dlc5_capture_generator1"));
    objective_add(1, "invisible", (0, 0, 0), istring("zm_dlc5_capture_generator1"));
    objective_add(2, "invisible", (0, 0, 0), istring("zm_dlc5_capture_generator1"));
    objective_add(3, "invisible", (0, 0, 0), istring("zm_dlc5_capture_generator1"));
    level.magic_box_zbarrier_state_func = &set_magic_box_zbarrier_state;
    level.custom_perk_validation = &check_perk_machine_valid;
    level thread function_76aa5572();
    foreach (s_generator in var_7b4a8f72) {
        if (!isdefined(s_generator.var_b454101b)) {
            foreach (var_b454101b in var_2dc6026c) {
                if (var_b454101b.script_noteworthy == s_generator.script_noteworthy) {
                    s_generator.var_b454101b = var_b454101b;
                    break;
                }
            }
        }
        s_generator thread function_dd1b941d();
    }
    function_a0cbb2f2();
    function_181e0c75();
    function_168ccda0();
    level thread function_3cee61b4();
    level.zone_capture.var_e941c50 = [];
    level.zone_capture.var_d23db1af = undefined;
    level.zone_capture.var_5ba5bba9 = &function_10a0d455;
    level.zone_capture.var_2aec2b0a = &function_2465105e;
    /#
        level thread function_e7e606b6();
        level thread function_5b801db4();
        level thread function_815b7f71();
    #/
    zm_spawner::register_zombie_death_event_callback(&function_df4ed2f3);
    level.custom_derive_damage_refs = &function_df69033a;
    function_400203be();
    level thread function_656366e3();
    level thread function_a6b76531();
    level thread function_8285c0cb();
    level flag::set("capture_zones_init_done");
    level clientfield::set("zone_capture_perk_machine_smoke_fx_always_on", 1);
    zm_tomb_capture_zones_ffotd::function_4a01e089();
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x7d0d6145, Offset: 0x1ef8
// Size: 0x1a4
function function_8285c0cb() {
    level flag::wait_till("all_zones_captured");
    level flag::wait_till_clear("story_vo_playing");
    zm_tomb_vo::function_eee384d4(1);
    level flag::set("story_vo_playing");
    e_speaker = function_41d2375a();
    if (isdefined(e_speaker)) {
        e_speaker zm_tomb_vo::function_c502e741(0);
        e_speaker zm_audio::create_and_play_dialog("zone_capture", "all_generators_captured");
        e_speaker function_a98fbefd();
    }
    e_richtofen = function_336d41bb("Richtofen");
    if (isdefined(e_richtofen)) {
        e_richtofen zm_tomb_vo::function_c502e741(0);
        e_richtofen zm_audio::create_and_play_dialog("zone_capture", "all_generators_captured");
    }
    zm_tomb_vo::function_eee384d4(0);
    level flag::clear("story_vo_playing");
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x26ea7fc6, Offset: 0x20a8
// Size: 0x66
function function_a98fbefd() {
    self endon(#"disconnect");
    self thread function_7b7c0a4e();
    self thread function_859f7d9c();
    str_msg = self waittill(#"hash_a227b4c7");
    self notify(#"hash_40238b64");
    return str_msg;
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x2f6fcc24, Offset: 0x2118
// Size: 0x4a
function function_859f7d9c() {
    self endon(#"hash_40238b64");
    while (isdefined(self.isspeaking) && self.isspeaking) {
        wait 0.05;
    }
    self notify(#"hash_a227b4c7", "sound_played");
}

// Namespace zm_tomb_capture_zones
// Params 1, eflags: 0x1 linked
// Checksum 0xda4c8006, Offset: 0x2170
// Size: 0x46
function function_7b7c0a4e(n_timeout) {
    if (!isdefined(n_timeout)) {
        n_timeout = 5;
    }
    self endon(#"hash_40238b64");
    wait n_timeout;
    self notify(#"hash_a227b4c7", "timeout");
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0xa5027a69, Offset: 0x21c0
// Size: 0xe4
function function_41d2375a() {
    a_players = getplayers();
    e_speaker = undefined;
    e_richtofen = function_336d41bb("Richtofen");
    if (isdefined(e_richtofen)) {
        if (a_players.size > 1) {
            arrayremovevalue(a_players, e_richtofen, 0);
            e_speaker = arraysort(a_players, e_richtofen.origin, 1)[0];
        } else {
            e_speaker = undefined;
        }
    } else {
        e_speaker = function_57b84ef5();
    }
    return e_speaker;
}

// Namespace zm_tomb_capture_zones
// Params 1, eflags: 0x1 linked
// Checksum 0x307794cd, Offset: 0x22b0
// Size: 0xcc
function function_336d41bb(var_88064c84) {
    var_f8fc9d6 = undefined;
    foreach (player in getplayers()) {
        if (isdefined(player.var_f7af1630) && player.var_f7af1630 == var_88064c84) {
            var_f8fc9d6 = player;
        }
    }
    return var_f8fc9d6;
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x5eb8146, Offset: 0x2388
// Size: 0x108
function function_656366e3() {
    while (true) {
        level waittill(#"revive_hide");
        wait 1;
        var_3e407ac7 = level.zone_capture.zones["generator_start_bunker"].perk_machines["revive"];
        if (level.zone_capture.zones["generator_start_bunker"] flag::get("player_controlled")) {
            level notify(#"revive_on");
            var_3e407ac7.is_locked = 0;
            var_3e407ac7 zm_perks::reset_vending_hint_string();
            continue;
        }
        level notify(#"revive_off");
        var_3e407ac7.is_locked = 1;
        var_3e407ac7 sethintstring(%ZM_TOMB_ZC);
    }
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0xb8f9ac8d, Offset: 0x2498
// Size: 0x64
function function_a6b76531() {
    if (level flag::exists("solo_revive")) {
        level flag::wait_till("solo_revive");
        level clientfield::set("zone_capture_perk_machine_smoke_fx_1", 0);
    }
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0xee0974a7, Offset: 0x2508
// Size: 0x44
function function_2c0b798b() {
    return !level flag::exists("solo_revive") || !level flag::get("solo_revive");
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x7bbe56ac, Offset: 0x2558
// Size: 0xa4
function function_400203be() {
    function_ff6d4708("generator_start_bunker", 5);
    function_ff6d4708("generator_start_bunker", 11);
    function_ff6d4708("generator_tank_trench", 4);
    function_ff6d4708("generator_tank_trench", 5);
    function_ff6d4708("generator_tank_trench", 6);
}

// Namespace zm_tomb_capture_zones
// Params 2, eflags: 0x1 linked
// Checksum 0x9912e281, Offset: 0x2608
// Size: 0x110
function function_ff6d4708(str_zone, n_index) {
    assert(isdefined(level.zone_capture.zones[str_zone]), "<dev string:x28>" + str_zone + "<dev string:x58>");
    level.zone_capture.zones[str_zone] flag::wait_till("zone_initialized");
    assert(isdefined(level.zone_capture.zones[str_zone].var_9a468804[n_index]), "<dev string:x7d>" + n_index + "<dev string:xb4>" + str_zone);
    level.zone_capture.zones[str_zone].var_9a468804[n_index].var_e37b377e = 1;
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x9f5a83cb, Offset: 0x2720
// Size: 0x2c
function function_181e0c75() {
    level.zone_capture.var_423bd7a2 = array("specialty_additionalprimaryweapon");
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0xf84f451b, Offset: 0x2758
// Size: 0xb8
function function_76aa5572() {
    while (true) {
        a_players = getplayers();
        foreach (player in a_players) {
            player.var_cad6ffdf = 0;
        }
        level waittill(#"between_round_over");
    }
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x2818
// Size: 0x4
function function_4a8fd3eb() {
    
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0xa304ba2d, Offset: 0x2828
// Size: 0x34
function function_168ccda0() {
    level function_a2bcb201(0);
    level thread function_8dc678e2();
}

// Namespace zm_tomb_capture_zones
// Params 1, eflags: 0x1 linked
// Checksum 0xae9daaea, Offset: 0x2868
// Size: 0x1da
function function_a2bcb201(b_show) {
    var_1f4b1fcf = self.pack_a_punch.triggers;
    if (b_show) {
        wait 2.5;
        foreach (t_trigger in var_1f4b1fcf) {
            t_trigger.pap_machine setvisibletoall();
            t_trigger.pap_machine _zm_pack_a_punch::set_state_power_on();
            t_trigger.pap_machine clientfield::set("pap_emissive_fx", 1);
        }
        return;
    }
    foreach (t_trigger in var_1f4b1fcf) {
        t_trigger.pap_machine setinvisibletoall();
        t_trigger.pap_machine _zm_pack_a_punch::set_state_hidden();
        t_trigger.pap_machine clientfield::set("pap_emissive_fx", 0);
    }
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x9f387c91, Offset: 0x2a50
// Size: 0xe0
function function_8dc678e2() {
    while (true) {
        level flag::wait_till("all_zones_captured");
        level notify(#"pack_a_punch_on");
        function_1a72e37b();
        level thread function_a2bcb201(1);
        exploder::exploder("lgtexp_exc_poweron");
        level flag::wait_till_clear("all_zones_captured");
        function_da067fb6();
        level thread function_a2bcb201(0);
        exploder::kill_exploder("lgtexp_exc_poweron");
    }
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x42c94df3, Offset: 0x2b38
// Size: 0x72
function function_1a72e37b() {
    level flag::set("power_on");
    level clientfield::set("zone_capture_hud_all_generators_captured", 1);
    if (!level flag::get("generator_lost_to_recapture_zombies")) {
        level notify(#"hash_aab28721");
    }
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x336a3603, Offset: 0x2bb8
// Size: 0x64
function function_da067fb6() {
    level flag::wait_till_clear("pack_machine_in_use");
    level clientfield::set("zone_capture_hud_all_generators_captured", 0);
    level flag::clear("power_on");
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0xeed215c, Offset: 0x2c28
// Size: 0x234
function function_a0cbb2f2() {
    function_1e46d552("generator_start_bunker", "starting_bunker");
    function_d6a0dae8("generator_start_bunker", "revive", "specialty_quickrevive", &function_2c0b798b);
    function_2555a1a3("generator_start_bunker", "bunker_start_chest");
    function_1e46d552("generator_tank_trench", "trenches_right");
    function_2555a1a3("generator_tank_trench", "bunker_tank_chest");
    function_1e46d552("generator_mid_trench", "trenches_left");
    function_d6a0dae8("generator_mid_trench", "sleight", "specialty_fastreload");
    function_2555a1a3("generator_mid_trench", "bunker_cp_chest");
    function_1e46d552("generator_nml_right", "nml");
    function_d6a0dae8("generator_nml_right", "juggernog", "specialty_armorvest");
    function_2555a1a3("generator_nml_right", "nml_open_chest");
    function_1e46d552("generator_nml_left", "farmhouse");
    function_d6a0dae8("generator_nml_left", "marathon", "specialty_staminup");
    function_2555a1a3("generator_nml_left", "nml_farm_chest");
    function_1e46d552("generator_church", "church");
    function_2555a1a3("generator_church", "village_church_chest");
}

// Namespace zm_tomb_capture_zones
// Params 4, eflags: 0x1 linked
// Checksum 0x5739b881, Offset: 0x2e68
// Size: 0x15c
function function_d6a0dae8(str_zone_name, str_perk_name, var_3d295e71, var_6130433a) {
    assert(isdefined(level.zone_capture.zones[str_zone_name]), "<dev string:xbe>" + str_zone_name + "<dev string:xe9>");
    if (!isdefined(level.zone_capture.zones[str_zone_name].perk_machines)) {
        level.zone_capture.zones[str_zone_name].perk_machines = [];
    }
    if (!isdefined(level.zone_capture.zones[str_zone_name].perk_machines[str_perk_name])) {
        var_f3313e2e = function_f97ede7c(var_3d295e71);
        var_f3313e2e.str_zone_name = str_zone_name;
        level.zone_capture.zones[str_zone_name].perk_machines[str_perk_name] = var_f3313e2e;
    }
    level.zone_capture.zones[str_zone_name].var_5448246b = var_6130433a;
}

// Namespace zm_tomb_capture_zones
// Params 2, eflags: 0x1 linked
// Checksum 0x9e5dd352, Offset: 0x2fd0
// Size: 0x278
function function_1e46d552(str_zone_name, str_identifier) {
    assert(isdefined(level.zone_capture.zones[str_zone_name]), "<dev string:x126>" + str_zone_name + "<dev string:xe9>");
    if (!isdefined(level.zone_capture.zones[str_zone_name].var_75009e68)) {
        level.zone_capture.zones[str_zone_name].var_75009e68 = [];
    }
    var_b33b534 = getentarray("perk_random_machine", "targetname");
    foreach (var_ab8a6005 in var_b33b534) {
        if (isdefined(var_ab8a6005.script_string) && var_ab8a6005.script_string == str_identifier) {
            if (!isdefined(level.zone_capture.zones[str_zone_name].var_75009e68)) {
                level.zone_capture.zones[str_zone_name].var_75009e68 = [];
            } else if (!isarray(level.zone_capture.zones[str_zone_name].var_75009e68)) {
                level.zone_capture.zones[str_zone_name].var_75009e68 = array(level.zone_capture.zones[str_zone_name].var_75009e68);
            }
            level.zone_capture.zones[str_zone_name].var_75009e68[level.zone_capture.zones[str_zone_name].var_75009e68.size] = var_ab8a6005;
        }
    }
}

// Namespace zm_tomb_capture_zones
// Params 2, eflags: 0x1 linked
// Checksum 0xb8ff6a95, Offset: 0x3250
// Size: 0x242
function function_2555a1a3(str_zone_name, str_identifier) {
    assert(isdefined(level.zone_capture.zones[str_zone_name]), "<dev string:x158>" + str_zone_name + "<dev string:xe9>");
    if (!isdefined(level.zone_capture.zones[str_zone_name].var_b1d64c7a)) {
        level.zone_capture.zones[str_zone_name].var_b1d64c7a = [];
    }
    var_163c36d8 = function_4bcb2da6(str_identifier);
    var_163c36d8.unitrigger_stub.prompt_and_visibility_func = &function_a2b30c04;
    var_163c36d8.unitrigger_stub.zone = str_zone_name;
    var_163c36d8.var_bb399418 = str_zone_name;
    var_163c36d8.zbarrier.var_bb399418 = str_zone_name;
    if (!isdefined(level.zone_capture.zones[str_zone_name].var_b1d64c7a)) {
        level.zone_capture.zones[str_zone_name].var_b1d64c7a = [];
    } else if (!isarray(level.zone_capture.zones[str_zone_name].var_b1d64c7a)) {
        level.zone_capture.zones[str_zone_name].var_b1d64c7a = array(level.zone_capture.zones[str_zone_name].var_b1d64c7a);
    }
    level.zone_capture.zones[str_zone_name].var_b1d64c7a[level.zone_capture.zones[str_zone_name].var_b1d64c7a.size] = var_163c36d8;
}

// Namespace zm_tomb_capture_zones
// Params 1, eflags: 0x1 linked
// Checksum 0x4b570044, Offset: 0x34a0
// Size: 0xf0
function function_4bcb2da6(str_script_noteworthy) {
    s_box = undefined;
    foreach (var_163c36d8 in level.chests) {
        if (isdefined(var_163c36d8.script_noteworthy) && var_163c36d8.script_noteworthy == str_script_noteworthy) {
            s_box = var_163c36d8;
        }
    }
    assert(isdefined(var_163c36d8), "<dev string:x182>" + str_script_noteworthy);
    return s_box;
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0xbdc9b631, Offset: 0x3598
// Size: 0xfe
function function_27d9a75f() {
    if (isdefined(self.perk_machines) && isarray(self.perk_machines)) {
        a_keys = getarraykeys(self.perk_machines);
        for (i = 0; i < a_keys.size; i++) {
            level notify(a_keys[i] + "_on");
        }
        for (i = 0; i < a_keys.size; i++) {
            var_61141f0 = self.perk_machines[a_keys[i]];
            var_61141f0.is_locked = 0;
            var_61141f0 zm_perks::reset_vending_hint_string();
        }
    }
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x3e5a289c, Offset: 0x36a0
// Size: 0x106
function function_cdfe4920() {
    if (isdefined(self.perk_machines) && isarray(self.perk_machines)) {
        a_keys = getarraykeys(self.perk_machines);
        for (i = 0; i < a_keys.size; i++) {
            level notify(a_keys[i] + "_off");
        }
        for (i = 0; i < a_keys.size; i++) {
            var_61141f0 = self.perk_machines[a_keys[i]];
            var_61141f0.is_locked = 1;
            var_61141f0 sethintstring(%ZM_TOMB_ZC);
        }
    }
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x86d66bf4, Offset: 0x37b0
// Size: 0x112
function function_26135431() {
    if (isdefined(self.var_75009e68) && isarray(self.var_75009e68)) {
        foreach (var_ab8a6005 in self.var_75009e68) {
            var_ab8a6005.is_locked = 0;
            if (isdefined(var_ab8a6005.current_perk_random_machine) && var_ab8a6005.current_perk_random_machine) {
                var_ab8a6005 zm_perk_random::set_perk_random_machine_state("idle");
                continue;
            }
            var_ab8a6005 zm_perk_random::set_perk_random_machine_state("away");
        }
    }
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0xf1e16206, Offset: 0x38d0
// Size: 0x112
function function_45bd830c() {
    if (isdefined(self.var_75009e68) && isarray(self.var_75009e68)) {
        foreach (var_ab8a6005 in self.var_75009e68) {
            var_ab8a6005.is_locked = 1;
            if (isdefined(var_ab8a6005.current_perk_random_machine) && var_ab8a6005.current_perk_random_machine) {
                var_ab8a6005 zm_perk_random::set_perk_random_machine_state("initial");
                continue;
            }
            var_ab8a6005 zm_perk_random::set_perk_random_machine_state("power_off");
        }
    }
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x416e2277, Offset: 0x39f0
// Size: 0xd2
function function_19b6ccfb() {
    foreach (var_d2fd4c32 in self.var_b1d64c7a) {
        var_d2fd4c32.is_locked = 0;
        var_d2fd4c32.zbarrier set_magic_box_zbarrier_state("player_controlled");
        var_d2fd4c32.zbarrier clientfield::set("magicbox_runes", 1);
    }
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x76806a19, Offset: 0x3ad0
// Size: 0xd2
function function_d126b318() {
    foreach (var_d2fd4c32 in self.var_b1d64c7a) {
        var_d2fd4c32.is_locked = 1;
        var_d2fd4c32.zbarrier set_magic_box_zbarrier_state("zombie_controlled");
        var_d2fd4c32.zbarrier clientfield::set("magicbox_runes", 0);
    }
}

// Namespace zm_tomb_capture_zones
// Params 1, eflags: 0x1 linked
// Checksum 0xd40e2525, Offset: 0x3bb0
// Size: 0x68
function function_f97ede7c(var_30b2017b) {
    e_trigger = getent(var_30b2017b, "script_noteworthy");
    assert(isdefined(e_trigger), "<dev string:x1e1>" + var_30b2017b);
    return e_trigger;
}

// Namespace zm_tomb_capture_zones
// Params 1, eflags: 0x1 linked
// Checksum 0x19694c2b, Offset: 0x3c20
// Size: 0xf0
function check_perk_machine_valid(player) {
    if (isdefined(self.script_noteworthy) && isinarray(level.zone_capture.var_423bd7a2, self.script_noteworthy)) {
        var_65e59c68 = 1;
    } else {
        assert(isdefined(self.str_zone_name), "<dev string:x240>");
        var_65e59c68 = level.zone_capture.zones[self.str_zone_name] flag::get("player_controlled");
    }
    if (!var_65e59c68) {
        player zm_audio::create_and_play_dialog("lockdown", "power_off");
    }
    return var_65e59c68;
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x60e0d60a, Offset: 0x3d18
// Size: 0x2ac
function function_dd1b941d() {
    assert(isdefined(self.script_noteworthy), "<dev string:x29a>");
    if (!isdefined(level.zone_capture)) {
        level.zone_capture = spawnstruct();
    }
    if (!isdefined(level.zone_capture.zones)) {
        level.zone_capture.zones = [];
    }
    assert(!isdefined(level.zone_capture.zones[self.script_noteworthy]), "<dev string:x2f9>" + self.script_noteworthy + "<dev string:x343>");
    self.n_current_progress = 0;
    self.var_668c40de = 0;
    self function_4579f14f();
    self.str_zone = zm_zonemgr::get_zone_from_position(self.origin, 1);
    self.sndent = spawn("script_origin", self.origin);
    assert(isdefined(self.script_int), "<dev string:x345>" + self.script_noteworthy + "<dev string:x343>");
    self flag::init("attacked_by_recapture_zombies");
    self flag::init("current_recapture_target_zone");
    self flag::init("player_controlled");
    self flag::init("zone_contested");
    self flag::init("zone_initialized");
    level.zone_capture.zones[self.script_noteworthy] = self;
    self function_365be7bf(1);
    self function_9fbff45e();
    self flag::set("zone_initialized");
    self thread function_cfaf1890();
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x146aba4d, Offset: 0x3fd0
// Size: 0x174
function function_4579f14f() {
    s_unitrigger_stub = spawnstruct();
    s_unitrigger_stub.origin = self.origin;
    s_unitrigger_stub.angles = self.angles;
    s_unitrigger_stub.radius = 32;
    s_unitrigger_stub.script_length = -128;
    s_unitrigger_stub.script_width = -128;
    s_unitrigger_stub.script_height = -128;
    s_unitrigger_stub.cursor_hint = "HINT_NOICON";
    s_unitrigger_stub.hint_string = %ZM_TOMB_CAP;
    s_unitrigger_stub.hint_parm1 = [[ &function_933a6645 ]]();
    s_unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    s_unitrigger_stub.require_look_at = 1;
    s_unitrigger_stub.prompt_and_visibility_func = &function_a16405f3;
    s_unitrigger_stub.var_31e12954 = self;
    zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger_stub, 1);
    zm_unitrigger::register_static_unitrigger(s_unitrigger_stub, &function_e3aedcac);
}

// Namespace zm_tomb_capture_zones
// Params 1, eflags: 0x1 linked
// Checksum 0xe18ce658, Offset: 0x4150
// Size: 0x118
function function_a16405f3(e_player) {
    var_bc42b2e2 = 1;
    s_zone = self.stub.var_31e12954;
    if (s_zone flag::get("zone_contested") || s_zone flag::get("player_controlled")) {
        var_bc42b2e2 = 0;
    }
    if (level flag::get("zone_capture_in_progress")) {
        self sethintstring(%ZM_TOMB_ZCIP);
    } else {
        self sethintstring(%ZM_TOMB_CAP, function_933a6645());
    }
    self setinvisibletoplayer(e_player, !var_bc42b2e2);
    return var_bc42b2e2;
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x9507e6e3, Offset: 0x4270
// Size: 0x1d8
function function_e3aedcac() {
    self endon(#"kill_trigger");
    while (true) {
        e_player = self waittill(#"trigger");
        if (!zombie_utility::is_player_valid(e_player) || e_player zm_laststand::is_reviving_any() || e_player != self.parent_player) {
            continue;
        }
        if (level flag::get("zone_capture_in_progress")) {
            continue;
        }
        if (zombie_utility::is_player_valid(e_player)) {
            self.stub.var_31e12954.var_6ba1f314 = function_933a6645();
            if (e_player zm_score::can_player_purchase(self.stub.var_31e12954.var_6ba1f314)) {
                e_player zm_score::minus_to_player_score(self.stub.var_31e12954.var_6ba1f314);
                self.purchaser = e_player;
            } else {
                zm_utility::play_sound_at_pos("no_purchase", self.origin);
                e_player zm_audio::create_and_play_dialog("general", "no_money_capture");
                continue;
            }
        }
        self setinvisibletoall();
        self.stub.var_31e12954 notify(#"hash_4f0e4e72", e_player);
    }
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x3383d158, Offset: 0x4450
// Size: 0xc4
function function_9fbff45e() {
    self.var_9a468804 = [];
    v_right = anglestoright(self.angles);
    self function_5809c189(self.origin, 0, 52);
    self function_5809c189(self.origin + v_right * -86, 4, 32);
    self function_5809c189(self.origin + v_right * -1 * -86, 8, 32);
}

// Namespace zm_tomb_capture_zones
// Params 3, eflags: 0x1 linked
// Checksum 0x98329d49, Offset: 0x4520
// Size: 0x156
function function_5809c189(v_origin, n_start_index, n_scale) {
    v_forward = anglestoforward(self.angles);
    v_right = anglestoright(self.angles);
    self.var_9a468804[n_start_index] = function_69ea2871(v_origin + v_forward * n_scale, v_origin);
    self.var_9a468804[n_start_index + 1] = function_69ea2871(v_origin + v_right * n_scale, v_origin);
    self.var_9a468804[n_start_index + 2] = function_69ea2871(v_origin + v_forward * -1 * n_scale, v_origin);
    self.var_9a468804[n_start_index + 3] = function_69ea2871(v_origin + v_right * -1 * n_scale, v_origin);
}

// Namespace zm_tomb_capture_zones
// Params 2, eflags: 0x1 linked
// Checksum 0xa5be3570, Offset: 0x4680
// Size: 0x88
function function_69ea2871(v_origin, var_1fd1c37a) {
    s_temp = spawnstruct();
    s_temp.is_claimed = 0;
    s_temp.var_6e1dc91c = undefined;
    s_temp.origin = v_origin;
    s_temp.var_e37b377e = 0;
    s_temp.var_1fd1c37a = var_1fd1c37a;
    return s_temp;
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0xadd64a8c, Offset: 0x4710
// Size: 0x200
function function_cfaf1890() {
    while (true) {
        e_player = self waittill(#"hash_4f0e4e72");
        if (!level flag::get("zone_capture_in_progress")) {
            level flag::set("zone_capture_in_progress");
            self.var_ea997a3c = e_player;
            e_player util::delay(2.5, undefined, &zm_audio::create_and_play_dialog, "zone_capture", "capture_started");
            self zm_tomb_capture_zones_ffotd::function_775c5fa5();
            self thread function_bef202e();
            self thread function_bf7495fa();
            self flag::wait_till("zone_contested");
            function_d773303e();
            self flag::wait_till_clear("zone_contested");
            self zm_tomb_capture_zones_ffotd::function_e68fe6();
            wait 1;
            self.var_ea997a3c = undefined;
        } else {
            level flag::wait_till("zone_capture_in_progress");
            level flag::wait_till_clear("zone_capture_in_progress");
        }
        function_d773303e();
        if (self flag::get("player_controlled")) {
            self flag::wait_till_clear("player_controlled");
        }
    }
}

// Namespace zm_tomb_capture_zones
// Params 1, eflags: 0x1 linked
// Checksum 0x5e7cdf67, Offset: 0x4918
// Size: 0xcc
function function_a872f146(e_player) {
    if (isinarray(self function_e9fd6b1e(), e_player)) {
        var_3c1c5605 = self.var_6ba1f314;
        var_faf5574c = level.zombie_vars["allies"]["zombie_point_scalar"] == 2;
        n_multiplier = 1;
        if (var_faf5574c) {
            n_multiplier = 0.5;
        }
        e_player zm_score::add_to_player_score(int(var_3c1c5605 * n_multiplier));
    }
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0xc88c662b, Offset: 0x49f0
// Size: 0x1e
function function_933a6645() {
    return -56 * getplayers().size;
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x82988a26, Offset: 0x4a18
// Size: 0xa8
function function_d773303e() {
    var_e587e522 = function_7d9c7d57();
    level.zombie_ai_limit = 24 - var_e587e522;
    while (zombie_utility::get_current_zombie_count() > level.zombie_ai_limit) {
        ai_zombie = function_dd49583a();
        if (isdefined(ai_zombie)) {
            ai_zombie thread function_2b1ad43b();
        }
        util::wait_network_frame();
    }
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0xc7f0ceaa, Offset: 0x4ac8
// Size: 0x5c
function function_dd49583a() {
    ai_zombie = undefined;
    a_zombies = zombie_utility::get_round_enemy_array();
    if (a_zombies.size > 0) {
        ai_zombie = array::random(a_zombies);
    }
    return ai_zombie;
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x7dd8b7dd, Offset: 0x4b30
// Size: 0x84
function function_2b1ad43b() {
    if (isdefined(self)) {
        playfx(level._effect["tesla_elec_kill"], self.origin);
        self ghost();
    }
    util::wait_network_frame();
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x10fe6aa3, Offset: 0x4bc0
// Size: 0x72
function function_7d9c7d57() {
    var_e587e522 = function_5fb09ca8();
    var_44d96a41 = 0;
    if (level flag::get("recapture_event_in_progress")) {
        var_44d96a41 = function_1476fb23();
    }
    return var_e587e522 + var_44d96a41;
}

// Namespace zm_tomb_capture_zones
// Params 1, eflags: 0x1 linked
// Checksum 0x6e59842d, Offset: 0x4c40
// Size: 0x168
function function_5fb09ca8(var_5c5bf862) {
    if (!isdefined(var_5c5bf862)) {
        var_5c5bf862 = 0;
    }
    var_9b68d0e8 = function_5dbbb045();
    switch (var_9b68d0e8.size) {
    case 0:
        var_e587e522 = 0;
        var_9d31ed7 = 0;
        break;
    case 1:
        var_e587e522 = 4;
        var_9d31ed7 = 4;
        break;
    case 2:
        var_e587e522 = 6;
        var_9d31ed7 = 3;
        break;
    case 3:
        var_e587e522 = 6;
        var_9d31ed7 = 2;
        break;
    case 4:
        var_e587e522 = 8;
        var_9d31ed7 = 2;
        break;
    default:
        /#
            iprintlnbold("<dev string:x3b3>" + var_9b68d0e8.size);
        #/
        var_e587e522 = 2 * var_9b68d0e8.size;
        var_9d31ed7 = 2;
        break;
    }
    if (var_5c5bf862) {
        var_f6109dbe = var_9d31ed7;
    }
    return var_e587e522;
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x9755cea7, Offset: 0x4db0
// Size: 0xe6
function function_cf0298d() {
    var_9b68d0e8 = function_5dbbb045();
    var_530e140 = function_5fb09ca8(1);
    foreach (zone in var_9b68d0e8) {
        if (zone flag::get("current_recapture_target_zone")) {
            continue;
        }
        zone.var_87ab8b0e = var_530e140;
    }
    return var_530e140;
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0xe0ba9b46, Offset: 0x4ea0
// Size: 0x3a
function function_1476fb23() {
    if (level.players.size == 1) {
        var_44d96a41 = 4;
    } else {
        var_44d96a41 = 6;
    }
    return var_44d96a41;
}

// Namespace zm_tomb_capture_zones
// Params 1, eflags: 0x1 linked
// Checksum 0x818fa93a, Offset: 0x4ee8
// Size: 0x184
function function_bf7495fa(var_97deea71) {
    if (!isdefined(var_97deea71)) {
        var_97deea71 = 1;
    }
    if (!level flag::get("recapture_event_in_progress")) {
        self thread function_5b2b85f0();
    }
    self.var_2d4c37ea = struct::get_array(self.target, "targetname");
    self function_fbcfdb74(var_97deea71);
    if (level flag::get("recapture_event_in_progress") && self flag::get("current_recapture_target_zone")) {
        self thread function_38a0fa7f();
        self thread function_de6d807b();
        level flag::wait_till_any(array("generator_under_attack", "recapture_zombies_cleared"));
        if (level flag::get("recapture_zombies_cleared")) {
            return;
        }
    }
    self function_2faef634();
    self function_605de203();
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x2fe65c29, Offset: 0x5078
// Size: 0x5c
function function_38a0fa7f() {
    level endon(#"recapture_zombies_cleared");
    self.var_b454101b waittill(#"attackable_damaged");
    level flag::set("generator_under_attack");
    self flag::set("attacked_by_recapture_zombies");
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0xa60915de, Offset: 0x50e0
// Size: 0x5c
function function_de6d807b() {
    level endon(#"recapture_zombies_cleared");
    self.var_b454101b waittill(#"attackable_deactivated");
    level flag::clear("generator_under_attack");
    self flag::clear("attacked_by_recapture_zombies");
}

// Namespace zm_tomb_capture_zones
// Params 1, eflags: 0x1 linked
// Checksum 0x33affc1b, Offset: 0x5148
// Size: 0x134
function function_fbcfdb74(var_97deea71) {
    self function_605de203();
    if (var_97deea71) {
        self.var_34408def = [];
        self.var_212b73fc = [];
        foreach (var_941c095a in self.var_2d4c37ea) {
            if (!isdefined(self.var_212b73fc)) {
                self.var_212b73fc = [];
            } else if (!isarray(self.var_212b73fc)) {
                self.var_212b73fc = array(self.var_212b73fc);
            }
            self.var_212b73fc[self.var_212b73fc.size] = var_941c095a function_dab017cd();
        }
    }
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x6211924e, Offset: 0x5288
// Size: 0x112
function function_605de203() {
    if (isdefined(self.var_212b73fc) && self.var_212b73fc.size > 0) {
        foreach (var_a211a5d9 in self.var_212b73fc) {
            if (isdefined(var_a211a5d9)) {
                var_a211a5d9 clientfield::set("zone_capture_emergence_hole", 0);
                var_a211a5d9 ghost();
                var_a211a5d9 thread function_f0b9364e(randomfloatrange(0.5, 2));
            }
            util::wait_network_frame();
        }
    }
}

// Namespace zm_tomb_capture_zones
// Params 1, eflags: 0x1 linked
// Checksum 0x73b3de01, Offset: 0x53a8
// Size: 0x2c
function function_f0b9364e(n_time) {
    wait n_time;
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0xa035d37b, Offset: 0x53e0
// Size: 0x1a8
function function_bef202e() {
    self flag::wait_till("zone_contested");
    var_6429c3ed = getent("capture_zombie_spawner", "targetname");
    self.var_3e26a2a1 = [];
    self.var_87ab8b0e = self function_cf0298d();
    while (self flag::get("zone_contested")) {
        self.var_3e26a2a1 = array::remove_dead(self.var_3e26a2a1);
        if (self.var_3e26a2a1.size < self.var_87ab8b0e) {
            ai = zombie_utility::spawn_zombie(var_6429c3ed);
            s_spawn_point = self function_954ee39d();
            ai thread [[ level.zone_capture.var_5ba5bba9 ]](self, s_spawn_point);
            if (!isdefined(self.var_3e26a2a1)) {
                self.var_3e26a2a1 = [];
            } else if (!isarray(self.var_3e26a2a1)) {
                self.var_3e26a2a1 = array(self.var_3e26a2a1);
            }
            self.var_3e26a2a1[self.var_3e26a2a1.size] = ai;
        }
        wait 0.5;
    }
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x47ade90a, Offset: 0x5590
// Size: 0x214
function function_1819168f() {
    var_6429c3ed = getent("capture_zombie_spawner", "targetname");
    self.var_87ab8b0e = function_1476fb23();
    var_e705192a = 0;
    self thread function_cc5e5b79();
    while (level flag::get("recapture_event_in_progress") && var_e705192a < self.var_87ab8b0e) {
        level.zone_capture.var_e941c50 = array::remove_dead(level.zone_capture.var_e941c50);
        ai = zombie_utility::spawn_zombie(var_6429c3ed);
        if (isdefined(ai)) {
            var_e705192a++;
            s_spawn_point = self function_954ee39d();
            ai thread [[ level.zone_capture.var_2aec2b0a ]](self, s_spawn_point);
            if (!isdefined(level.zone_capture.var_e941c50)) {
                level.zone_capture.var_e941c50 = [];
            } else if (!isarray(level.zone_capture.var_e941c50)) {
                level.zone_capture.var_e941c50 = array(level.zone_capture.var_e941c50);
            }
            level.zone_capture.var_e941c50[level.zone_capture.var_e941c50.size] = ai;
        }
        wait 0.5;
    }
    level function_f9115ae8();
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0xe67b01b4, Offset: 0x57b0
// Size: 0x4c
function function_cc5e5b79() {
    self endon(#"zone_contested");
    level endon(#"recapture_event_in_progress");
    self waittill(#"hash_40a0155d");
    function_82e1a903("recapture_generator_attacked", 3.5);
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x5f9cd1ac, Offset: 0x5808
// Size: 0x98
function function_954ee39d() {
    while (true) {
        if (isdefined(self.var_2d4c37ea) && self.var_2d4c37ea.size > 0) {
            s_spawn_point = self function_8a07f36c();
            s_spawn_point.var_dabf8ae2 = 1;
            return s_spawn_point;
        } else {
            self.var_2d4c37ea = struct::get_array(self.target, "targetname");
        }
        wait 0.05;
    }
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x511c2939, Offset: 0x58a8
// Size: 0x174
function function_8a07f36c() {
    a_valid_spawn_points = [];
    for (var_1bbdbab3 = 0; !a_valid_spawn_points.size; var_1bbdbab3 = 1) {
        foreach (var_fa927b2b in self.var_2d4c37ea) {
            if (!isdefined(var_fa927b2b.var_dabf8ae2) || var_1bbdbab3) {
                var_fa927b2b.var_dabf8ae2 = 0;
            }
            if (!var_fa927b2b.var_dabf8ae2) {
                if (!isdefined(a_valid_spawn_points)) {
                    a_valid_spawn_points = [];
                } else if (!isarray(a_valid_spawn_points)) {
                    a_valid_spawn_points = array(a_valid_spawn_points);
                }
                a_valid_spawn_points[a_valid_spawn_points.size] = var_fa927b2b;
            }
        }
        if (!a_valid_spawn_points.size) {
        }
    }
    s_spawn_point = array::random(a_valid_spawn_points);
    return s_spawn_point;
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0xc6af090f, Offset: 0x5a28
// Size: 0x98
function function_dab017cd() {
    var_a211a5d9 = spawn("script_model", self.origin);
    var_a211a5d9.angles = self.angles;
    var_a211a5d9 setmodel("p7_zm_ori_dig_mound_hole");
    util::wait_network_frame();
    var_a211a5d9 clientfield::set("zone_capture_emergence_hole", 1);
    return var_a211a5d9;
}

// Namespace zm_tomb_capture_zones
// Params 1, eflags: 0x1 linked
// Checksum 0x9e1c015c, Offset: 0x5ac8
// Size: 0xb4
function function_a14a64d8(s_spawn_point) {
    self setphysparams(15, 0, 72);
    self.ignore_enemy_count = 1;
    self.b_ignore_cleanup = 1;
    self zm_tomb_utility::function_83fc6b30(s_spawn_point);
    self playsound("zmb_vocals_capzomb_spawn");
    self clientfield::set("zone_capture_zombie", 1);
    self function_14e7b25a();
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x7f1a1e0e, Offset: 0x5b88
// Size: 0x8c
function function_14e7b25a() {
    self asmsetanimationrate(1);
    self clientfield::set("anim_rate", 1);
    n_rate = self clientfield::get("anim_rate");
    self setentityanimrate(n_rate);
}

// Namespace zm_tomb_capture_zones
// Params 3, eflags: 0x1 linked
// Checksum 0x4af1a241, Offset: 0x5c20
// Size: 0x98
function function_df69033a(refs, point, weaponname) {
    if (isdefined(self.var_43465c48) && self.var_43465c48) {
        arrayremovevalue(refs, "right_leg", 0);
        arrayremovevalue(refs, "left_leg", 0);
        arrayremovevalue(refs, "no_legs", 0);
    }
    return refs;
}

// Namespace zm_tomb_capture_zones
// Params 2, eflags: 0x1 linked
// Checksum 0xc92ef01d, Offset: 0x5cc0
// Size: 0xc4
function function_10a0d455(zone_struct, s_spawn_point) {
    self endon(#"death");
    self function_a14a64d8(s_spawn_point);
    if (isdefined(self.zombie_move_speed) && self.zombie_move_speed == "walk") {
        self.zombie_move_speed = "run";
        self zombie_utility::set_zombie_run_cycle("run");
    }
    find_flesh_struct_string = "find_flesh";
    self notify(#"zombie_custom_think_done", find_flesh_struct_string);
    self thread function_1fb89946(zone_struct);
}

// Namespace zm_tomb_capture_zones
// Params 2, eflags: 0x1 linked
// Checksum 0xdf87f9c4, Offset: 0x5d90
// Size: 0xc8
function function_2465105e(zone_struct, s_spawn_point) {
    self endon(#"death");
    self.var_43465c48 = 1;
    self.ignoremelee = 1;
    self ai::set_behavior_attribute("use_attackable", 1);
    self function_a14a64d8(s_spawn_point);
    self.goalradius = 30;
    self zombie_utility::set_zombie_run_cycle("sprint");
    self.var_dfb19f30 = 1;
    function_f8f10b07(zone_struct);
    self.var_b84cee45 = 1;
}

// Namespace zm_tomb_capture_zones
// Params 1, eflags: 0x0
// Checksum 0xac500107, Offset: 0x5e60
// Size: 0x64
function function_36aa72fb(ai_zombie) {
    playfx(level._effect["zone_capture_zombie_spawn"], self.origin, anglestoforward(self.angles), anglestoup(self.angles));
}

// Namespace zm_tomb_capture_zones
// Params 1, eflags: 0x1 linked
// Checksum 0x1b226273, Offset: 0x5ed0
// Size: 0x250
function function_1eadb62(s_zone) {
    s_zone function_cc6e846();
    var_cde077c5 = s_zone function_4d8d21d6(0, 3);
    var_70adbf5d = s_zone function_4d8d21d6(4, 7);
    var_2d92b940 = s_zone function_4d8d21d6(8, 11);
    var_dc9a94a = var_cde077c5 < 3;
    var_d45c7342 = var_70adbf5d < 1;
    var_f7a4b809 = var_2d92b940 < 1;
    if (var_dc9a94a) {
        var_1b572b82 = s_zone function_4e6e564f(0, 3);
    } else if (var_d45c7342) {
        var_1b572b82 = s_zone function_4e6e564f(4, 7);
    } else if (var_f7a4b809) {
        var_1b572b82 = s_zone function_4e6e564f(8, 11);
    } else {
        var_1b572b82 = s_zone function_4e6e564f(0, 11);
    }
    if (var_1b572b82.size == 0) {
        var_1b572b82 = s_zone function_4e6e564f(0, 11);
    }
    assert(var_1b572b82.size > 0, "<dev string:x3f9>" + s_zone.script_noteworthy);
    var_6829d61c = array::random(var_1b572b82);
    var_6829d61c.is_claimed = 1;
    var_6829d61c.var_6e1dc91c = self;
    return var_6829d61c;
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x48a59d4f, Offset: 0x6128
// Size: 0xb8
function function_cc6e846() {
    foreach (var_6829d61c in self.var_9a468804) {
        if (var_6829d61c.is_claimed && !isdefined(var_6829d61c.var_6e1dc91c)) {
            var_6829d61c.is_claimed = 0;
            var_6829d61c.var_6e1dc91c = undefined;
        }
    }
}

// Namespace zm_tomb_capture_zones
// Params 2, eflags: 0x1 linked
// Checksum 0xf05f4ff4, Offset: 0x61e8
// Size: 0xf0
function function_4e6e564f(n_start, var_77d40fdb) {
    var_1b572b82 = [];
    for (i = n_start; i < var_77d40fdb; i++) {
        if (!self.var_9a468804[i].is_claimed && !self.var_9a468804[i].var_e37b377e) {
            if (!isdefined(var_1b572b82)) {
                var_1b572b82 = [];
            } else if (!isarray(var_1b572b82)) {
                var_1b572b82 = array(var_1b572b82);
            }
            var_1b572b82[var_1b572b82.size] = self.var_9a468804[i];
        }
    }
    return var_1b572b82;
}

// Namespace zm_tomb_capture_zones
// Params 2, eflags: 0x1 linked
// Checksum 0xfba87a8b, Offset: 0x62e0
// Size: 0xd2
function function_4d8d21d6(n_start, var_77d40fdb) {
    var_ca3e8299 = [];
    for (i = n_start; i < var_77d40fdb; i++) {
        if (self.var_9a468804[i].is_claimed) {
            if (!isdefined(var_ca3e8299)) {
                var_ca3e8299 = [];
            } else if (!isarray(var_ca3e8299)) {
                var_ca3e8299 = array(var_ca3e8299);
            }
            var_ca3e8299[var_ca3e8299.size] = self.var_9a468804[i];
        }
    }
    return var_ca3e8299.size;
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x75fc2fb9, Offset: 0x63c0
// Size: 0x1a
function function_14d55782() {
    self.is_claimed = 0;
    self.var_6e1dc91c = undefined;
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x38e98146, Offset: 0x63e8
// Size: 0x8a
function function_741d1015() {
    foreach (var_6829d61c in self.var_9a468804) {
        var_6829d61c function_14d55782();
    }
}

// Namespace zm_tomb_capture_zones
// Params 1, eflags: 0x1 linked
// Checksum 0xec85cf0b, Offset: 0x6480
// Size: 0x18c
function function_1fb89946(s_zone) {
    self endon(#"death");
    n_goal_radius = self.goalradius;
    while (true) {
        self.goalradius = n_goal_radius;
        if (self function_e808756d(s_zone)) {
            self notify(#"stop_find_flesh");
            self notify(#"zombie_acquire_enemy");
            self.ignore_find_flesh = 1;
            self.goalradius = 30;
            if (!isdefined(self.var_767c8094)) {
                self.var_767c8094 = self function_1eadb62(s_zone);
            }
            self setgoalpos(self.var_767c8094.origin);
            self thread function_89a66743(s_zone);
            str_notify = self util::waittill_any_return("goal", "stop_attacking_generator", "death");
            if (str_notify === "stop_attacking_generator") {
                self.var_767c8094 function_14d55782();
            } else {
                self function_9eba6bee();
                continue;
            }
        }
        wait 0.5;
    }
}

// Namespace zm_tomb_capture_zones
// Params 1, eflags: 0x1 linked
// Checksum 0xde132778, Offset: 0x6618
// Size: 0x98
function function_89a66743(s_zone) {
    self notify(#"hash_97124bd1");
    self endon(#"hash_97124bd1");
    self endon(#"death");
    while (true) {
        if (!self function_e808756d(s_zone)) {
            self notify(#"stop_attacking_generator");
            self.ignore_find_flesh = 0;
            break;
        }
        wait randomfloatrange(0.2, 1.5);
    }
}

// Namespace zm_tomb_capture_zones
// Params 1, eflags: 0x1 linked
// Checksum 0xc5e9f065, Offset: 0x66b8
// Size: 0x23e
function function_e808756d(s_zone) {
    a_players = getplayers();
    a_valid_targets = arraysort(a_players, s_zone.origin, 1, undefined, 700);
    foreach (player in a_players) {
        if (!isdefined(self.ignore_player)) {
            self.ignore_player = [];
        }
        b_is_valid_target = isinarray(a_valid_targets, player) && zombie_utility::is_player_valid(player);
        var_448e20e0 = isinarray(self.ignore_player, player);
        if (b_is_valid_target && var_448e20e0) {
            arrayremovevalue(self.ignore_player, player, 0);
            continue;
        }
        if (!b_is_valid_target && !var_448e20e0) {
            if (!isdefined(self.ignore_player)) {
                self.ignore_player = [];
            } else if (!isarray(self.ignore_player)) {
                self.ignore_player = array(self.ignore_player);
            }
            self.ignore_player[self.ignore_player.size] = player;
        }
    }
    var_d403d23e = a_valid_targets.size == 0 || isdefined(self.enemy) && self.ignore_player.size == a_players.size;
    return var_d403d23e;
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x1e6c1c1c, Offset: 0x6900
// Size: 0x15e
function function_9eba6bee() {
    self endon(#"death");
    self endon(#"hash_bb4f2dd8");
    v_angles = self.angles;
    if (isdefined(self.var_767c8094)) {
        v_angles = self.var_767c8094.var_1fd1c37a - self.origin;
        v_angles = vectortoangles((v_angles[0], v_angles[1], 0));
    }
    var_ae686a3e = [];
    var_ae686a3e[var_ae686a3e.size] = "ai_zombie_base_ad_attack_v1";
    var_ae686a3e[var_ae686a3e.size] = "ai_zombie_base_ad_attack_v2";
    var_ae686a3e[var_ae686a3e.size] = "ai_zombie_base_ad_attack_v3";
    var_ae686a3e[var_ae686a3e.size] = "ai_zombie_base_ad_attack_v4";
    var_ae686a3e = array::randomize(var_ae686a3e);
    self animscripted("attack_anim", self.origin, v_angles, var_ae686a3e[0]);
    time = getanimlength(var_ae686a3e[0]);
    wait time;
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x0
// Checksum 0x3d1e9c46, Offset: 0x6a68
// Size: 0x17e
function function_bf0b2c19() {
    self endon(#"death");
    self.var_322dc7fc = 0;
    while (isdefined(self) && isalive(self)) {
        if (isdefined(level.var_67a73ecb)) {
            zombie_poi = self [[ level.var_67a73ecb ]]();
        }
        if (!isdefined(zombie_poi)) {
            zombie_poi = self zm_utility::get_zombie_point_of_interest(self.origin);
        }
        self.var_cced3d54 = self.var_322dc7fc;
        if (isdefined(zombie_poi) && isarray(zombie_poi) && isdefined(zombie_poi[1])) {
            self.goalradius = 16;
            self.var_322dc7fc = 1;
            self.var_b84cee45 = 0;
            self.var_5bcacaf8 = zombie_poi[0];
        } else {
            self.goalradius = 30;
            self.var_322dc7fc = 0;
            self.var_5bcacaf8 = undefined;
            zombie_poi = undefined;
        }
        if (self.var_cced3d54 != self.var_322dc7fc) {
            self notify(#"hash_bb4f2dd8");
            self stopanimscripted(0.2);
        }
        wait 1;
    }
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0xf714a23f, Offset: 0x6bf0
// Size: 0x164
function function_d0d5148a() {
    while (isdefined(self.var_3e26a2a1) && self.var_3e26a2a1.size > 0) {
        foreach (zombie in self.var_3e26a2a1) {
            if (isdefined(zombie) && isalive(zombie)) {
                playfx(level._effect["tesla_elec_kill"], zombie.origin);
                zombie dodamage(zombie.health + 100, zombie.origin);
            }
            util::wait_network_frame();
        }
        self.var_3e26a2a1 = array::remove_dead(self.var_3e26a2a1);
    }
    self.var_3e26a2a1 = [];
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x74afdc67, Offset: 0x6d60
// Size: 0x194
function function_2171cf83() {
    while (isdefined(level.zone_capture.var_e941c50) && level.zone_capture.var_e941c50.size > 0) {
        foreach (zombie in level.zone_capture.var_e941c50) {
            if (isdefined(zombie) && isalive(zombie)) {
                playfx(level._effect["tesla_elec_kill"], zombie.origin);
                zombie dodamage(zombie.health + 100, zombie.origin);
            }
            util::wait_network_frame();
        }
        level.zone_capture.var_e941c50 = array::remove_dead(level.zone_capture.var_e941c50);
    }
    level.zone_capture.var_e941c50 = [];
}

// Namespace zm_tomb_capture_zones
// Params 1, eflags: 0x0
// Checksum 0x3f757cb, Offset: 0x6f00
// Size: 0xb4
function function_6cb51741(var_a5b9d3b2) {
    if (var_a5b9d3b2.is_occupied) {
        return true;
    }
    foreach (var_6c504c8c in var_a5b9d3b2.var_ce4ae306) {
        if (var_6c504c8c.is_occupied) {
            return true;
        }
    }
    return false;
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x943d4cf7, Offset: 0x6fc0
// Size: 0x44
function function_c46a59ae() {
    level.zone_capture.var_d23db1af = self;
    self function_3262a99f();
    self function_77eb083(1);
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x601af2bb, Offset: 0x7010
// Size: 0x6c
function function_e9075fcc() {
    level.var_804e92fe = function_5a72a0e1();
    if (level.var_804e92fe == 6) {
        level flag::set("all_zones_captured");
        return;
    }
    level flag::clear("all_zones_captured");
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x597bc2f6, Offset: 0x7088
// Size: 0xb6
function function_5a72a0e1() {
    var_712f7104 = 0;
    foreach (generator in level.zone_capture.zones) {
        if (generator flag::get("player_controlled")) {
            var_712f7104++;
        }
    }
    return var_712f7104;
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x116eef8a, Offset: 0x7148
// Size: 0x14
function function_ff29dac6() {
    return function_5dbbb045().size;
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0xe0956fa3, Offset: 0x7168
// Size: 0x10c
function function_5dbbb045() {
    var_9b68d0e8 = [];
    foreach (generator in level.zone_capture.zones) {
        if (generator flag::get("zone_contested")) {
            if (!isdefined(var_9b68d0e8)) {
                var_9b68d0e8 = [];
            } else if (!isarray(var_9b68d0e8)) {
                var_9b68d0e8 = array(var_9b68d0e8);
            }
            var_9b68d0e8[var_9b68d0e8.size] = generator;
        }
    }
    return var_9b68d0e8;
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x9cd09d61, Offset: 0x7280
// Size: 0x232
function function_3262a99f() {
    if (!self flag::get("player_controlled")) {
        foreach (e_player in level.players) {
            e_player thread zm_craftables::function_97be99b3(undefined, "zmInventory.capture_generator_wheel_widget", 0);
        }
    }
    self flag::set("player_controlled");
    self flag::clear("attacked_by_recapture_zombies");
    level clientfield::set("zone_capture_hud_generator_" + self.script_int, 1);
    level clientfield::set("zone_capture_monolith_crystal_" + self.script_int, 0);
    if (!isdefined(self.var_5448246b) || [[ self.var_5448246b ]]()) {
        level clientfield::set("zone_capture_perk_machine_smoke_fx_" + self.script_int, 1);
    }
    self flag::set("player_controlled");
    function_e9075fcc();
    self function_27d9a75f();
    self function_26135431();
    self function_19b6ccfb();
    self function_c3b54f6d();
    level notify(#"hash_b57b5e8c", self.str_zone);
}

// Namespace zm_tomb_capture_zones
// Params 1, eflags: 0x1 linked
// Checksum 0xf551827b, Offset: 0x74c0
// Size: 0x10c
function function_365be7bf(var_3ab0c475) {
    if (!isdefined(var_3ab0c475)) {
        var_3ab0c475 = 0;
    }
    function_e9075fcc();
    if (var_3ab0c475) {
        level clientfield::set("state_" + self.script_noteworthy, 3);
        util::wait_network_frame();
        level clientfield::set("state_" + self.script_noteworthy, 0);
    }
    if (self flag::get("player_controlled")) {
        level flag::set("generator_lost_to_recapture_zombies");
    }
    self function_af7ee316(var_3ab0c475);
    self function_77eb083(0);
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0xaab66034, Offset: 0x75d8
// Size: 0xc4
function function_b0debead() {
    level flag::wait_till("start_zombie_round_logic");
    var_5102e5a = function_5a72a0e1();
    if (var_5102e5a > 0) {
        level clientfield::set("packapunch_anim", 0);
        return;
    }
    if (var_5102e5a == 0) {
        level clientfield::set("packapunch_anim", 6);
        wait 5;
        level clientfield::set("packapunch_anim", 0);
    }
}

// Namespace zm_tomb_capture_zones
// Params 1, eflags: 0x1 linked
// Checksum 0x2775089c, Offset: 0x76a8
// Size: 0x3c
function function_77eb083(var_58bd1248) {
    level clientfield::set("packapunch_anim", function_5a72a0e1());
}

// Namespace zm_tomb_capture_zones
// Params 1, eflags: 0x1 linked
// Checksum 0x7ee2addd, Offset: 0x76f0
// Size: 0x204
function function_af7ee316(var_3ab0c475) {
    if (!isdefined(var_3ab0c475)) {
        var_3ab0c475 = 0;
    }
    var_61afe629 = 2;
    if (var_3ab0c475) {
        var_61afe629 = 0;
    }
    if (!var_3ab0c475 && self flag::get("player_controlled")) {
        foreach (e_player in level.players) {
            e_player thread zm_craftables::function_97be99b3(undefined, "zmInventory.capture_generator_wheel_widget", 0);
        }
    }
    self flag::clear("player_controlled");
    level clientfield::set("zone_capture_hud_generator_" + self.script_int, var_61afe629);
    level clientfield::set("zone_capture_monolith_crystal_" + self.script_int, 1);
    level clientfield::set("zone_capture_perk_machine_smoke_fx_" + self.script_int, 0);
    function_e9075fcc();
    self function_cdfe4920();
    self function_45bd830c();
    self function_d126b318();
    if (!var_3ab0c475) {
        self function_1138b343();
    }
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x16a71f90, Offset: 0x7900
// Size: 0x3c
function function_c3b54f6d() {
    var_43157bc9 = "power_on" + self.script_int;
    level flag::set(var_43157bc9);
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0xa3b371, Offset: 0x7948
// Size: 0x3c
function function_1138b343() {
    var_43157bc9 = "power_on" + self.script_int;
    level flag::clear(var_43157bc9);
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x8e64ec44, Offset: 0x7990
// Size: 0x484
function function_2faef634() {
    self function_391d882a();
    self function_aa9b95e0();
    self function_85409d54(1);
    self function_9c3f02ad();
    while (self flag::get("zone_contested")) {
        a_players = getplayers();
        var_b3786e17 = self function_e9fd6b1e();
        foreach (player in a_players) {
            if (isinarray(var_b3786e17, player)) {
                if (!level flag::get("recapture_event_in_progress") || !self flag::get("current_recapture_target_zone")) {
                    objective_setplayerusing(self.var_cadf2f1c, player);
                }
                continue;
            }
            if (zombie_utility::is_player_valid(player)) {
                objective_clearplayerusing(self.var_cadf2f1c, player);
            }
        }
        self.var_668c40de = self.n_current_progress;
        self.n_current_progress += self function_a0b7b4c(var_b3786e17.size, a_players.size);
        if (self.var_668c40de != self.n_current_progress) {
            self.n_current_progress = math::clamp(self.n_current_progress, 0, 100);
            objective_setprogress(self.var_cadf2f1c, self.n_current_progress / 100);
            self function_362d297();
            level clientfield::set(self.script_noteworthy, self.n_current_progress / 100);
            self function_7b69fd5f();
            if (!level flag::get("recapture_event_in_progress") || !self flag::get("attacked_by_recapture_zombies")) {
                var_8ef544c6 = var_b3786e17.size > 0;
                if (!level flag::get("recapture_event_in_progress") && self flag::get("current_recapture_target_zone")) {
                    var_8ef544c6 = 1;
                }
                level clientfield::set("zc_change_progress_bar_color", var_8ef544c6);
            }
            function_7ab22526();
            if (self.n_current_progress == 100 && (self.n_current_progress == 0 || !self flag::get("attacked_by_recapture_zombies"))) {
                self flag::clear("zone_contested");
            }
        }
        function_ed67843b();
        wait 0.1;
    }
    self flag::clear("attacked_by_recapture_zombies");
    self function_533880ee();
    self function_741d1015();
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x852abacc, Offset: 0x7e20
// Size: 0xbc
function function_7ab22526() {
    if (self flag::get("current_recapture_target_zone") && !level flag::get("recapture_event_in_progress") && self.var_cadf2f1c == 1 && self.n_current_progress > self.var_668c40de) {
        self function_aa9b95e0();
        self function_85409d54(1);
        level clientfield::set("zc_change_progress_bar_color", 1);
    }
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x18a5413b, Offset: 0x7ee8
// Size: 0x8e
function function_9c3f02ad() {
    if (!isdefined(self.var_cadf2f1c)) {
        if (self flag::get("current_recapture_target_zone")) {
            if (level flag::get("recapture_event_in_progress")) {
                var_8f945c55 = 1;
            } else {
                var_8f945c55 = 2;
            }
        } else {
            var_8f945c55 = 0;
        }
        self.var_cadf2f1c = var_8f945c55;
    }
    return self.var_cadf2f1c;
}

// Namespace zm_tomb_capture_zones
// Params 1, eflags: 0x1 linked
// Checksum 0x43d85fcd, Offset: 0x7f80
// Size: 0xc8
function function_8d4fbeb7(n_index) {
    var_541b0481 = 0;
    foreach (zone in level.zone_capture.zones) {
        if (isdefined(zone.var_cadf2f1c) && zone.var_cadf2f1c == n_index) {
            var_541b0481++;
        }
    }
    return var_541b0481;
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0xf90bf41a, Offset: 0x8050
// Size: 0xc0
function function_362d297() {
    if (!isdefined(self.var_8ccc35e9)) {
        self.var_8ccc35e9 = 0;
    }
    if (self.n_current_progress > self.var_668c40de) {
        if (self.var_8ccc35e9) {
            self.sndent stoploopsound();
            self.var_8ccc35e9 = 0;
        }
        return;
    }
    if (!self.var_8ccc35e9 && level flag::get("generator_under_attack")) {
        self.sndent playloopsound("zmb_capturezone_generator_alarm", 0.25);
        self.var_8ccc35e9 = 1;
    }
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x2b243ea1, Offset: 0x8118
// Size: 0x4c
function function_d545328() {
    self function_85409d54(0);
    util::wait_network_frame();
    level clientfield::set("zc_change_progress_bar_color", 0);
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x7152e599, Offset: 0x8170
// Size: 0x194
function function_533880ee() {
    self thread function_d545328();
    if (self.n_current_progress == 100) {
        self function_175f5f97();
        self function_d0d5148a();
        level clientfield::set("state_" + self.script_noteworthy, 6);
    } else if (self.n_current_progress == 0) {
        if (self flag::get("player_controlled")) {
            self.sndent stoploopsound(0.25);
            self thread function_7cca847b();
            self.var_8ccc35e9 = 0;
        }
        self function_365be7bf();
        if (level flag::get("recapture_event_in_progress") && function_5a72a0e1() > 0) {
        } else {
            self function_d0d5148a();
        }
    }
    if (function_ff29dac6() == 0) {
        level flag::clear("zone_capture_in_progress");
    }
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x657e2fbe, Offset: 0x8310
// Size: 0x194
function function_391d882a() {
    if (!isdefined(level.zone_capture.var_c6b26cd4)) {
        level.zone_capture.var_c6b26cd4 = function_9ef909a(10);
    }
    if (!isdefined(level.zone_capture.var_d3b639e2)) {
        level.zone_capture.var_d3b639e2 = function_9ef909a(12);
    }
    if (!isdefined(level.zone_capture.var_a84f030c)) {
        level.zone_capture.var_a84f030c = function_9ef909a(20) * -1;
    }
    if (!isdefined(level.zone_capture.var_51274291)) {
        level.zone_capture.var_51274291 = function_9ef909a(40) * -1;
    }
    if (!isdefined(level.zone_capture.var_68bb9272)) {
        level.zone_capture.var_68bb9272 = function_9ef909a(10);
    }
    if (!self flag::get("player_controlled")) {
        self.n_current_progress = 0;
        self flag::clear("attacked_by_recapture_zombies");
    }
    self flag::set("zone_contested");
}

// Namespace zm_tomb_capture_zones
// Params 2, eflags: 0x1 linked
// Checksum 0x4a2978ee, Offset: 0x84b0
// Size: 0x18c
function function_a0b7b4c(n_players_in_zone, var_6acb4269) {
    if (level flag::get("recapture_event_in_progress") && self flag::get("current_recapture_target_zone")) {
        if (self function_16898891() > 0) {
            n_rate = level.zone_capture.var_51274291;
        } else if (!self flag::get("attacked_by_recapture_zombies")) {
            n_rate = 0;
        } else {
            n_rate = level.zone_capture.var_68bb9272;
        }
    } else if (self flag::get("current_recapture_target_zone")) {
        n_rate = level.zone_capture.var_68bb9272;
    } else if (n_players_in_zone > 0) {
        if (level.players.size == 1) {
            n_rate = level.zone_capture.var_d3b639e2;
        } else {
            n_rate = level.zone_capture.var_c6b26cd4 * n_players_in_zone / var_6acb4269;
        }
    } else {
        n_rate = level.zone_capture.var_a84f030c;
    }
    return n_rate;
}

// Namespace zm_tomb_capture_zones
// Params 1, eflags: 0x1 linked
// Checksum 0x5d440eba, Offset: 0x8648
// Size: 0xac
function function_85409d54(b_show_objective) {
    self function_9c3f02ad();
    if (b_show_objective) {
        objective_add(self.var_cadf2f1c, "active", self.origin, istring("zm_dlc5_capture_generator" + self.script_int));
        objective_setvisibletoall(self.var_cadf2f1c);
        return;
    }
    self function_aa9b95e0();
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0xff16d838, Offset: 0x8700
// Size: 0x102
function function_aa9b95e0() {
    if (isdefined(self.var_cadf2f1c) && function_8d4fbeb7(self.var_cadf2f1c) < 2) {
        objective_state(self.var_cadf2f1c, "invisible");
        a_players = getplayers();
        foreach (player in a_players) {
            objective_clearplayerusing(self.var_cadf2f1c, player);
        }
    }
    self.var_cadf2f1c = undefined;
}

// Namespace zm_tomb_capture_zones
// Params 1, eflags: 0x1 linked
// Checksum 0xac4dda9d, Offset: 0x8810
// Size: 0xcc
function function_95166ca5(var_48b63d90) {
    self function_aa9b95e0();
    level flag::clear("generator_under_attack");
    if (!var_48b63d90) {
        function_28dab345();
    }
    do {
        wait 1;
    } while (!level flag::get("recapture_zombies_cleared") && self function_16898891() == 0);
    if (!level flag::get("recapture_zombies_cleared")) {
        self thread function_8adf4f47();
    }
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x2501b18f, Offset: 0x88e8
// Size: 0x154
function function_28dab345() {
    level endon(#"recapture_zombies_cleared");
    if (isdefined(level.zone_capture.var_e941c50) && level flag::get("recapture_event_in_progress")) {
        while (!level.zone_capture.var_e941c50.size) {
            util::wait_network_frame();
            level.zone_capture.var_e941c50 = array::remove_dead(level.zone_capture.var_e941c50);
        }
        level flag::wait_till_clear("generator_under_attack");
        if (level.zone_capture.var_e941c50.size > 0) {
            ai_zombie = array::random(level.zone_capture.var_e941c50);
            objective_add(3, "active", ai_zombie, istring("zm_dlc5_recapture_zombie"));
            ai_zombie thread function_8dd3fa76();
        }
    }
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0xe3e2901f, Offset: 0x8a48
// Size: 0xcc
function function_8dd3fa76() {
    while (isalive(self) && !level flag::get("generator_under_attack")) {
        /#
            debugstar(self.origin, 20, (1, 0, 0));
        #/
        wait 1;
    }
    function_12003d06();
    util::wait_network_frame();
    if (!level flag::get("recapture_zombies_cleared")) {
        function_28dab345();
    }
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x5bfbba3e, Offset: 0x8b20
// Size: 0x54
function function_12003d06() {
    objective_state(3, "invisible");
    if (isalive(self)) {
        objective_clearentity(3);
    }
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0xef99d03a, Offset: 0x8b80
// Size: 0x154
function function_175f5f97() {
    self.sndent playsound("zmb_capturezone_success");
    self.sndent stoploopsound(0.25);
    util::wait_network_frame();
    if (!level flag::get("recapture_event_in_progress") && !self flag::get("player_controlled")) {
        self thread function_b9dbb140();
    }
    function_29276681();
    self function_c46a59ae();
    if (isdefined(self.var_ea997a3c)) {
        self function_a872f146(self.var_ea997a3c);
    }
    util::wait_network_frame();
    playfx(level._effect["capture_complete"], self.origin);
    level thread function_91cad12a();
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0xca233ce8, Offset: 0x8ce0
// Size: 0x11a
function function_29276681() {
    var_ab36a906 = zm_challenges_tomb::function_db40117f("zc_zone_captures");
    if (!self flag::get("player_controlled")) {
        foreach (player in function_e9fd6b1e()) {
            player notify(#"completed_zone_capture");
            player zm_score::player_add_points("bonus_points_powerup", 100);
            if (var_ab36a906) {
                player zm_challenges_tomb::function_6b433789("zc_zone_captures");
            }
        }
    }
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0xf15341a1, Offset: 0x8e08
// Size: 0x1d2
function function_ed67843b() {
    /#
        if (getdvarint("<dev string:x445>") > 0) {
            print3d(self.origin, "<dev string:x458>" + self.n_current_progress, (0, 1, 0));
            circle(groundtrace(self.origin, self.origin - (0, 0, 1000), 0, undefined)["<dev string:x464>"], -36, (0, 1, 0), 0, 4);
            foreach (n_index, var_e1ae22da in self.var_9a468804) {
                if (var_e1ae22da.var_e37b377e) {
                    v_color = (1, 1, 1);
                } else if (var_e1ae22da.is_claimed) {
                    v_color = (1, 0, 0);
                } else {
                    v_color = (0, 1, 0);
                }
                debugstar(var_e1ae22da.origin, 4, v_color);
                print3d(var_e1ae22da.origin + (0, 0, 10), n_index, v_color, 1, 1, 4);
            }
        }
    #/
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0xf57de2b9, Offset: 0x8fe8
// Size: 0x164
function function_e9fd6b1e() {
    var_b3786e17 = [];
    foreach (player in getplayers()) {
        if (zombie_utility::is_player_valid(player) && distance2dsquared(player.origin, self.origin) < 48400 && player.origin[2] > self.origin[2] + -20) {
            if (!isdefined(var_b3786e17)) {
                var_b3786e17 = [];
            } else if (!isarray(var_b3786e17)) {
                var_b3786e17 = array(var_b3786e17);
            }
            var_b3786e17[var_b3786e17.size] = player;
        }
    }
    return var_b3786e17;
}

// Namespace zm_tomb_capture_zones
// Params 1, eflags: 0x1 linked
// Checksum 0xf0be75a3, Offset: 0x9158
// Size: 0x32
function function_9ef909a(n_duration) {
    var_bfda8ba4 = 100 / n_duration * 0.1;
    return var_bfda8ba4;
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x1b205db3, Offset: 0x9198
// Size: 0x134
function function_7b69fd5f() {
    var_888cf125 = level clientfield::get("state_" + self.script_noteworthy);
    if (self.n_current_progress == 0) {
        self function_897916ba();
        return;
    }
    if (var_888cf125 == 0 && self.n_current_progress > 0) {
        self function_13c6336c();
        return;
    }
    if (self function_f146acf8()) {
        self function_d6df70a8();
        return;
    }
    if (var_888cf125 == 2 && self.n_current_progress < self.var_668c40de) {
        self function_a5796577();
        if (!level flag::get("recapture_event_in_progress")) {
            self thread function_31d88faf();
        }
    }
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x48311ed8, Offset: 0x92d8
// Size: 0x38
function function_13c6336c() {
    level clientfield::set("state_" + self.script_noteworthy, 1);
    self.var_6abd7de7 = gettime();
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0xb8a59107, Offset: 0x9318
// Size: 0x2c
function function_d6df70a8() {
    level clientfield::set("state_" + self.script_noteworthy, 2);
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0xe8e65740, Offset: 0x9350
// Size: 0x6c
function function_a5796577() {
    if (self flag::get("attacked_by_recapture_zombies")) {
        n_state = 5;
    } else {
        n_state = 3;
    }
    level clientfield::set("state_" + self.script_noteworthy, n_state);
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0xb1d41dca, Offset: 0x93c8
// Size: 0x44
function function_897916ba() {
    level clientfield::set("state_" + self.script_noteworthy, 4);
    self thread function_aa7d2b4();
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x5a4c83cb, Offset: 0x9418
// Size: 0x3c
function function_aa7d2b4() {
    wait getanimlength(generic%p7_fxanim_zm_ori_generator_end_anim);
    self function_12e0a3c4();
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0xac867058, Offset: 0x9460
// Size: 0x2c
function function_12e0a3c4() {
    level clientfield::set("state_" + self.script_noteworthy, 0);
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x67c4c6b4, Offset: 0x9498
// Size: 0x84
function function_f146acf8() {
    if (!isdefined(self.var_6abd7de7)) {
        self.var_6abd7de7 = 0;
    }
    if (!isdefined(self.var_f12872e)) {
        self.var_f12872e = getanimlength(generic%p7_fxanim_zm_ori_generator_start_anim);
    }
    return self.n_current_progress > self.var_668c40de && (gettime() - self.var_6abd7de7) * 0.001 > self.var_f12872e;
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0xd5bfe571, Offset: 0x9528
// Size: 0xf0
function function_16898891() {
    var_4e53e908 = 0;
    foreach (zombie in level.zone_capture.var_e941c50) {
        if (isdefined(zombie.var_b84cee45) && isalive(zombie) && zombie.var_b84cee45 && self.script_noteworthy === level.zone_capture.var_f777760c) {
            var_4e53e908++;
        }
    }
    return var_4e53e908;
}

/#

    // Namespace zm_tomb_capture_zones
    // Params 0, eflags: 0x1 linked
    // Checksum 0xcfc60a01, Offset: 0x9620
    // Size: 0x112
    function function_e7e606b6() {
        level waittill(#"open_sesame");
        level.var_b78734a9 = 1;
        var_a75bc907 = struct::get_array("<dev string:x46d>", "<dev string:x479>");
        foreach (s_generator in var_a75bc907) {
            s_temp = level.zone_capture.zones[s_generator.script_noteworthy];
            s_temp function_c0bae7e6();
            util::wait_network_frame();
        }
    }

    // Namespace zm_tomb_capture_zones
    // Params 0, eflags: 0x1 linked
    // Checksum 0x64e5ef23, Offset: 0x9740
    // Size: 0xee
    function function_5b801db4() {
        while (true) {
            n_zone = level waittill(#"hash_bbcb5d8c");
            foreach (zone in level.zone_capture.zones) {
                if (zone.script_int == n_zone && !zone flag::get("<dev string:x484>")) {
                    zone function_c0bae7e6();
                }
            }
        }
    }

    // Namespace zm_tomb_capture_zones
    // Params 0, eflags: 0x1 linked
    // Checksum 0xd0ecf56c, Offset: 0x9838
    // Size: 0xee
    function function_815b7f71() {
        while (true) {
            n_zone = level waittill(#"hash_d9f2eac9");
            foreach (zone in level.zone_capture.zones) {
                if (zone.script_int == n_zone && zone flag::get("<dev string:x484>")) {
                    zone function_c2e8c83b();
                }
            }
        }
    }

    // Namespace zm_tomb_capture_zones
    // Params 0, eflags: 0x1 linked
    // Checksum 0x859094b3, Offset: 0x9930
    // Size: 0x64
    function function_c0bae7e6() {
        self function_c46a59ae();
        self.n_current_progress = 100;
        self function_d6df70a8();
        level clientfield::set(self.script_noteworthy, self.n_current_progress / 100);
    }

    // Namespace zm_tomb_capture_zones
    // Params 0, eflags: 0x1 linked
    // Checksum 0xd4494bfb, Offset: 0x99a0
    // Size: 0x64
    function function_c2e8c83b() {
        self function_365be7bf();
        self.n_current_progress = 0;
        self function_897916ba();
        level clientfield::set(self.script_noteworthy, self.n_current_progress / 100);
    }

#/

// Namespace zm_tomb_capture_zones
// Params 1, eflags: 0x1 linked
// Checksum 0x7c75d9a0, Offset: 0x9a10
// Size: 0x50a
function set_magic_box_zbarrier_state(state) {
    for (i = 0; i < self getnumzbarrierpieces(); i++) {
        self hidezbarrierpiece(i);
    }
    self notify(#"zbarrier_state_change");
    switch (state) {
    case "away":
        self showzbarrierpiece(0);
        self.state = "away";
        self.owner.is_locked = 0;
        break;
    case "arriving":
        self showzbarrierpiece(1);
        self thread namespace_bafc277e::function_4831fb0d();
        self.state = "arriving";
        break;
    case "initial":
        self showzbarrierpiece(1);
        self thread zm_magicbox::function_fea04511();
        thread zm_unitrigger::register_static_unitrigger(self.owner.unitrigger_stub, &zm_magicbox::magicbox_unitrigger_think);
        self.state = "close";
        break;
    case "open":
        self showzbarrierpiece(2);
        self thread namespace_bafc277e::function_63e09f12();
        self.state = "open";
        break;
    case "close":
        self showzbarrierpiece(2);
        self thread namespace_bafc277e::function_fe30a0c8();
        self.state = "close";
        break;
    case "leaving":
        self showzbarrierpiece(1);
        self thread namespace_bafc277e::function_fd5f77b3();
        self.state = "leaving";
        self.owner.is_locked = 0;
        break;
    case "zombie_controlled":
        if (isdefined(level.zombie_vars["zombie_powerup_fire_sale_on"]) && level.zombie_vars["zombie_powerup_fire_sale_on"]) {
            self showzbarrierpiece(2);
            self clientfield::set("magicbox_amb_fx", 0);
        }
        if (self.state == "initial" || self.state == "close") {
            self showzbarrierpiece(1);
            self clientfield::set("magicbox_amb_fx", 1);
        } else if (self.state == "away") {
            self showzbarrierpiece(0);
            self clientfield::set("magicbox_amb_fx", 0);
        } else if (self.state == "open" || self.state == "leaving") {
            self showzbarrierpiece(2);
            self clientfield::set("magicbox_amb_fx", 0);
        }
        break;
    case "player_controlled":
        if (self.state == "arriving" || self.state == "close") {
            self showzbarrierpiece(2);
            self clientfield::set("magicbox_amb_fx", 2);
            break;
        }
        if (self.state == "away") {
            self showzbarrierpiece(0);
            self clientfield::set("magicbox_amb_fx", 3);
        }
        break;
    default:
        if (isdefined(level.custom_magicbox_state_handler)) {
            self [[ level.custom_magicbox_state_handler ]](state);
        }
        break;
    }
}

// Namespace zm_tomb_capture_zones
// Params 1, eflags: 0x1 linked
// Checksum 0x59719c2b, Offset: 0x9f28
// Size: 0x90
function function_a2b30c04(player) {
    can_use = self function_31bfb6d2(player);
    if (isdefined(self.hint_string)) {
        if (isdefined(self.hint_parm1)) {
            self sethintstring(self.hint_string, self.hint_parm1);
        } else {
            self sethintstring(self.hint_string);
        }
    }
    return can_use;
}

// Namespace zm_tomb_capture_zones
// Params 1, eflags: 0x1 linked
// Checksum 0x8ed0d6e, Offset: 0x9fc0
// Size: 0x1d0
function function_31bfb6d2(player) {
    if (!self zm_magicbox::trigger_visible_to_player(player)) {
        return false;
    }
    self.hint_parm1 = undefined;
    if (isdefined(self.stub.trigger_target.grab_weapon_hint) && self.stub.trigger_target.grab_weapon_hint) {
        cursor_hint = "HINT_WEAPON";
        cursor_hint_weapon = self.stub.trigger_target.grab_weapon;
        self setcursorhint(cursor_hint, cursor_hint_weapon);
        if (isdefined(level.magic_box_check_equipment) && [[ level.magic_box_check_equipment ]](cursor_hint_weapon)) {
            self.hint_string = %ZOMBIE_TRADE_EQUIP_FILL;
        } else {
            self.hint_string = %ZOMBIE_TRADE_WEAPON_FILL;
        }
    } else {
        self setcursorhint("HINT_NOICON");
        if (!level.zone_capture.zones[self.stub.zone] flag::get("player_controlled")) {
            self.hint_string = %ZM_TOMB_ZC;
            return false;
        } else {
            self.hint_parm1 = self.stub.trigger_target.zombie_cost;
            self.hint_string = zm_utility::get_hint_string(self, "default_treasure_chest");
        }
    }
    return true;
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x49cac944, Offset: 0xa198
// Size: 0x138
function function_3cee61b4() {
    var_c45b88ec = 10;
    while (true) {
        /#
            iprintln("<dev string:x496>" + var_c45b88ec);
        #/
        level util::waittill_any("between_round_over", "force_recapture_start");
        /#
            if (getdvarint("<dev string:x4ae>") > 0) {
                var_c45b88ec = level.round_number;
            }
        #/
        if (level.round_number >= var_c45b88ec && !level flag::get("zone_capture_in_progress") && function_5a72a0e1() >= function_c6a6f725()) {
            var_c45b88ec = level.round_number + randomintrange(3, 6);
            level thread function_424d7c34();
        }
    }
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x938ad78d, Offset: 0xa2d8
// Size: 0x48
function function_c6a6f725() {
    var_407c81c7 = 4;
    /#
        if (getdvarint("<dev string:x4ae>") > 0) {
            var_407c81c7 = 1;
        }
    #/
    return var_407c81c7;
}

// Namespace zm_tomb_capture_zones
// Params 1, eflags: 0x1 linked
// Checksum 0xe355cd67, Offset: 0xa328
// Size: 0x2e6
function function_6b584eba(var_a866a38e) {
    var_a7730d40 = [];
    foreach (str_key, s_zone in level.zone_capture.zones) {
        if (s_zone flag::get("player_controlled")) {
            var_a7730d40[str_key] = s_zone;
        }
    }
    var_d1be77d3 = undefined;
    if (var_a7730d40.size) {
        if (isdefined(var_a866a38e)) {
            var_531f7eb9 = undefined;
            foreach (s_zone in var_a7730d40) {
                n_distance = distancesquared(s_zone.origin, var_a866a38e.origin);
                if (!isdefined(var_531f7eb9) || n_distance < var_531f7eb9) {
                    var_d1be77d3 = s_zone;
                    var_531f7eb9 = n_distance;
                }
            }
        } else {
            var_d1be77d3 = array::random(var_a7730d40);
            /#
                if (getdvarint("<dev string:x4c2>") > 0) {
                    n_zone = getdvarint("<dev string:x4c2>");
                    foreach (zone in level.zone_capture.zones) {
                        if (n_zone == zone.script_int && zone flag::get("<dev string:x484>")) {
                            var_d1be77d3 = zone;
                            break;
                        }
                    }
                }
            #/
        }
    }
    return var_d1be77d3;
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x9cba1971, Offset: 0xa618
// Size: 0x554
function function_424d7c34() {
    level flag::set("recapture_event_in_progress");
    level flag::clear("recapture_zombies_cleared");
    level flag::clear("generator_under_attack");
    level.var_9d32f018 = 0;
    var_95b26ca4 = 1;
    var_9c45216b = undefined;
    function_d773303e();
    function_ac8e6f96();
    var_c746b61a = struct::get_array("generator_attackable", "targetname");
    foreach (var_b454101b in var_c746b61a) {
        var_b454101b zm_attackables::deactivate();
        var_b454101b.health = 1000000;
        var_b454101b.max_health = var_b454101b.health;
        var_b454101b.aggro_distance = 1024;
    }
    while (!level flag::get("recapture_zombies_cleared") && function_5a72a0e1() > 0) {
        var_9c45216b = function_6b584eba(var_9c45216b);
        var_28e07566 = var_9c45216b.var_b454101b;
        level.zone_capture.var_f777760c = var_9c45216b.script_noteworthy;
        level.zone_capture.var_186a84eb = var_28e07566;
        var_9c45216b zm_tomb_capture_zones_ffotd::function_af3aaaf0();
        var_28e07566 zm_attackables::activate();
        if (var_95b26ca4) {
            var_9c45216b thread function_1819168f();
            util::delay(10, undefined, &function_82e1a903, "recapture_generator_attacked");
        }
        var_9c45216b thread function_5e3742f6();
        var_9c45216b flag::set("current_recapture_target_zone");
        var_9c45216b thread function_95166ca5(var_95b26ca4);
        var_9c45216b function_bf7495fa(var_95b26ca4);
        var_9c45216b flag::clear("attacked_by_recapture_zombies");
        var_9c45216b flag::clear("current_recapture_target_zone");
        var_28e07566 zm_attackables::deactivate();
        if (!var_9c45216b flag::get("player_controlled")) {
            util::delay(3, undefined, &function_82e1a903, "recapture_started");
        }
        var_95b26ca4 = 0;
        var_9c45216b zm_tomb_capture_zones_ffotd::function_7b4eb003();
        wait 0.05;
    }
    if (var_9c45216b.n_current_progress == 0 || var_9c45216b.n_current_progress == 100) {
        var_9c45216b function_533880ee();
    }
    function_d773303e();
    function_2171cf83();
    function_b2b05d97();
    var_c746b61a = struct::get_array("generator_attackable", "targetname");
    foreach (var_b454101b in var_c746b61a) {
        var_b454101b zm_attackables::deactivate();
    }
    level flag::clear("recapture_event_in_progress");
    level flag::clear("generator_under_attack");
}

// Namespace zm_tomb_capture_zones
// Params 2, eflags: 0x1 linked
// Checksum 0x77c5b782, Offset: 0xab78
// Size: 0x17e
function function_82e1a903(str_category, n_delay) {
    if (!isdefined(n_delay)) {
        n_delay = 1;
    }
    a_players = getplayers();
    a_speakers = [];
    do {
        e_speaker = function_57b84ef5(a_players);
        if (!isdefined(a_speakers)) {
            a_speakers = [];
        } else if (!isarray(a_speakers)) {
            a_speakers = array(a_speakers);
        }
        a_speakers[a_speakers.size] = e_speaker;
        arrayremovevalue(a_players, e_speaker);
        a_players = e_speaker function_9ee5346a(a_players);
    } while (a_players.size > 0);
    for (i = 0; i < a_speakers.size; i++) {
        a_speakers[i] util::delay(n_delay, undefined, &zm_audio::create_and_play_dialog, "zone_capture", str_category);
    }
}

// Namespace zm_tomb_capture_zones
// Params 1, eflags: 0x1 linked
// Checksum 0xceda071, Offset: 0xad00
// Size: 0x14c
function function_9ee5346a(a_players) {
    var_d23791b8 = [];
    foreach (player in a_players) {
        if (distancesquared(player.origin, self.origin) > 640000 && zombie_utility::is_player_valid(player) && !player isplayeronsamemachine(self)) {
            if (!isdefined(var_d23791b8)) {
                var_d23791b8 = [];
            } else if (!isarray(var_d23791b8)) {
                var_d23791b8 = array(var_d23791b8);
            }
            var_d23791b8[var_d23791b8.size] = player;
        }
    }
    return var_d23791b8;
}

// Namespace zm_tomb_capture_zones
// Params 1, eflags: 0x1 linked
// Checksum 0x9a61af39, Offset: 0xae58
// Size: 0x132
function function_57b84ef5(a_players) {
    if (!isdefined(a_players)) {
        a_players = getplayers();
    }
    a_valid_players = [];
    foreach (player in a_players) {
        if (zombie_utility::is_player_valid(player)) {
            if (!isdefined(a_valid_players)) {
                a_valid_players = [];
            } else if (!isarray(a_valid_players)) {
                a_valid_players = array(a_valid_players);
            }
            a_valid_players[a_valid_players.size] = player;
        }
    }
    return array::random(a_valid_players);
}

// Namespace zm_tomb_capture_zones
// Params 1, eflags: 0x1 linked
// Checksum 0x783897ad, Offset: 0xaf98
// Size: 0x4c
function function_f8f10b07(var_9c45216b) {
    level flag::clear("generator_under_attack");
    var_9c45216b flag::clear("attacked_by_recapture_zombies");
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x0
// Checksum 0xf4a77d50, Offset: 0xaff0
// Size: 0x7c
function function_48f2d1dd() {
    level endon(#"hash_2771912d");
    wait 5;
    ent = spawn("script_origin", (0, 0, 0));
    ent playloopsound("mus_recapture_round_loop", 5);
    ent thread function_d928a8f8();
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0xfc0a618b, Offset: 0xb078
// Size: 0x54
function function_d928a8f8() {
    level flag::wait_till("recapture_zombies_cleared");
    self stoploopsound(2);
    wait 2;
    self delete();
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x461f3d55, Offset: 0xb0d8
// Size: 0x120
function function_f9115ae8() {
    while (true) {
        level.zone_capture.var_e941c50 = array::remove_dead(level.zone_capture.var_e941c50);
        if (level.zone_capture.var_e941c50.size == 0) {
            level flag::set("recapture_zombies_cleared");
            level flag::clear("recapture_event_in_progress");
            level flag::clear("generator_under_attack");
            if (isdefined(level.zone_capture.var_f777760c)) {
                level.zone_capture.zones[level.zone_capture.var_f777760c] flag::clear("attacked_by_recapture_zombies");
                level.zone_capture.var_f777760c = undefined;
            }
            break;
        }
        wait 1;
    }
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x7f1ab80d, Offset: 0xb200
// Size: 0x174
function function_df4ed2f3() {
    if (isdefined(self.var_43465c48) && self.var_43465c48) {
        level.var_9d32f018++;
        if (isdefined(self.attacker) && isplayer(self.attacker) && level.var_9d32f018 == function_1476fb23()) {
            self.attacker thread util::delay(2, undefined, &zm_audio::create_and_play_dialog, "zone_capture", "recapture_prevented");
            foreach (player in getplayers()) {
            }
        }
        if (level.var_9d32f018 == function_1476fb23() && level flag::get("generator_under_attack")) {
            self function_85fb49e9();
        }
    }
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0xe7b28fe, Offset: 0xb380
// Size: 0x94
function function_85fb49e9() {
    if (isdefined(self)) {
        var_2c5cd825 = groundtrace(self.origin + (0, 0, 10), self.origin + (0, 0, -150), 0, undefined, 1)["position"];
    }
    if (isdefined(var_2c5cd825)) {
        level thread zm_powerups::specific_powerup_drop("full_ammo", var_2c5cd825);
    }
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x53d82b6, Offset: 0xb420
// Size: 0x11c
function function_5e3742f6() {
    level flag::wait_till_any(array("generator_under_attack", "recapture_zombies_cleared"));
    if (!level flag::get("recapture_zombies_cleared")) {
        var_3991a614 = spawn("script_origin", self.origin);
        var_3991a614 playloopsound("zmb_capturezone_losing");
        var_3991a614 thread function_2e0e852a();
        wait 0.5;
        level flag::wait_till_clear("generator_under_attack");
        var_3991a614 stoploopsound(0.2);
        wait 0.5;
        var_3991a614 delete();
    }
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x6892a84b, Offset: 0xb548
// Size: 0x7e
function function_2e0e852a() {
    self endon(#"death");
    n_end_time = gettime() + 5000;
    while (level flag::get("generator_under_attack")) {
        playfx(level._effect["lght_marker_flare"], self.origin);
        wait 4;
    }
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x4749abdf, Offset: 0xb5d0
// Size: 0x2c
function function_ac8e6f96() {
    level.var_1b7d7bb8 = 1;
    level thread zm_audio::sndmusicsystem_playstate("round_start_recap");
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x2305c45, Offset: 0xb608
// Size: 0x3e
function function_b2b05d97() {
    level thread zm_audio::sndmusicsystem_playstate("round_end_recap");
    level.var_1b7d7bb8 = 0;
    level notify(#"hash_2771912d");
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0xb650
// Size: 0x4
function function_3f903f04() {
    
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0xb660
// Size: 0x4
function function_31c032() {
    
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x52b12b29, Offset: 0xb670
// Size: 0x94
function function_5b2b85f0() {
    var_fe164365 = spawn("script_origin", self.origin);
    level.var_75e514e3 = 1;
    var_fe164365 playsoundwithnotify("vox_maxi_generator_initiate_0", "vox_maxi_generator_initiate_0_done");
    var_fe164365 waittill(#"vox_maxi_generator_initiate_0_done");
    level.var_75e514e3 = 0;
    var_fe164365 delete();
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0xc9d431c4, Offset: 0xb710
// Size: 0xe4
function function_b9dbb140() {
    var_fe164365 = spawn("script_origin", self.origin);
    var_fe164365 playsoundwithnotify("vox_maxi_generator_process_complete_0", "vox_maxi_generator_process_complete_0_done");
    var_fe164365 waittill(#"vox_maxi_generator_process_complete_0_done");
    var_fe164365 playsoundwithnotify("vox_maxi_generator_" + self.script_int + "_activated_0", "vox_maxi_generator_" + self.script_int + "_activated_0_done");
    var_fe164365 waittill("vox_maxi_generator_" + self.script_int + "_activated_0_done");
    var_fe164365 delete();
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0xe8f91551, Offset: 0xb800
// Size: 0x7c
function function_31d88faf() {
    var_fe164365 = spawn("script_origin", self.origin);
    var_fe164365 playsoundwithnotify("vox_maxi_generator_interrupted_0", "vox_maxi_generator_interrupted_0_done");
    var_fe164365 waittill(#"vox_maxi_generator_interrupted_0_done");
    var_fe164365 delete();
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0xa0d3673a, Offset: 0xb888
// Size: 0xb4
function function_8adf4f47() {
    var_fe164365 = spawn("script_origin", self.origin);
    var_fe164365 playsoundwithnotify("vox_maxi_generator_" + self.script_int + "_compromised_0", "vox_maxi_generator_" + self.script_int + "_compromised_0_done");
    var_fe164365 waittill("vox_maxi_generator_" + self.script_int + "_compromised_0_done");
    var_fe164365 delete();
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0x870da3ae, Offset: 0xb948
// Size: 0xb4
function function_7cca847b() {
    var_fe164365 = spawn("script_origin", self.origin);
    var_fe164365 playsoundwithnotify("vox_maxi_generator_" + self.script_int + "_deactivated_0", "vox_maxi_generator_" + self.script_int + "_deactivated_0_done");
    var_fe164365 waittill("vox_maxi_generator_" + self.script_int + "_deactivated_0_done");
    var_fe164365 delete();
}

// Namespace zm_tomb_capture_zones
// Params 0, eflags: 0x1 linked
// Checksum 0xbfdf4b54, Offset: 0xba08
// Size: 0x44
function function_91cad12a() {
    num = function_5a72a0e1();
    level thread zm_tomb_amb::function_5f9c184e("generator_" + num);
}

