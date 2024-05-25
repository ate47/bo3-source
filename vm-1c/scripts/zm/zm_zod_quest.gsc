#using scripts/zm/zm_zod_util;
#using scripts/zm/zm_zod_vo;
#using scripts/zm/zm_zod_quest_vo;
#using scripts/zm/zm_zod_portals;
#using scripts/zm/zm_zod_pods;
#using scripts/zm/zm_zod_margwa;
#using scripts/zm/zm_zod_defend_areas;
#using scripts/zm/zm_zod_craftables;
#using scripts/zm/craftables/_zm_craftables;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_pack_a_punch_util;
#using scripts/zm/_zm_magicbox;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm;
#using scripts/zm/_load;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/music_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/animation_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace namespace_1f61c67f;

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x2
// Checksum 0xe1ebcaa8, Offset: 0x1610
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_zod_quest", &__init__, undefined, undefined);
}

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x1 linked
// Checksum 0xecfa08c2, Offset: 0x1650
// Size: 0xdfc
function __init__() {
    level.pap_zbarrier_state_func = &function_b35b6cb3;
    callback::on_connect(&on_player_connect);
    clientfield::register("toplayer", "ZM_ZOD_UI_SUMMONING_KEY_PICKUP", 1, 1, "int");
    clientfield::register("toplayer", "ZM_ZOD_UI_RITUAL_BUSY", 1, 1, "int");
    clientfield::register("world", "quest_key", 1, 1, "int");
    clientfield::register("world", "ritual_progress", 1, 7, "float");
    clientfield::register("world", "ritual_current", 1, 3, "int");
    n_bits = getminbitcountfornum(5);
    clientfield::register("world", "ritual_state_boxer", 1, n_bits, "int");
    clientfield::register("world", "ritual_state_detective", 1, n_bits, "int");
    clientfield::register("world", "ritual_state_femme", 1, n_bits, "int");
    clientfield::register("world", "ritual_state_magician", 1, n_bits, "int");
    clientfield::register("world", "ritual_state_pap", 1, n_bits, "int");
    clientfield::register("world", "keeper_spawn_portals", 1, 4, "int");
    clientfield::register("world", "keeper_subway_fx", 1, 1, "int");
    clientfield::register("world", "junction_crane_state", 1, 1, "int");
    clientfield::register("scriptmover", "cursetrap_fx", 1, 1, "int");
    clientfield::register("scriptmover", "mini_cursetrap_fx", 1, 1, "int");
    clientfield::register("scriptmover", "curse_tell_fx", 1, 1, "int");
    clientfield::register("scriptmover", "darkportal_fx", 1, 1, "int");
    clientfield::register("scriptmover", "boss_shield_fx", 1, 1, "int");
    clientfield::register("scriptmover", "keeper_symbol_fx", 1, 1, "int");
    n_bits = getminbitcountfornum(6);
    clientfield::register("scriptmover", "totem_state_fx", 1, n_bits, "int");
    clientfield::register("scriptmover", "totem_damage_fx", 1, 3, "int");
    clientfield::register("scriptmover", "set_fade_material", 1, 1, "int");
    clientfield::register("scriptmover", "set_subway_wall_dissolve", 1, 1, "int");
    n_bits = getminbitcountfornum(3);
    clientfield::register("actor", "status_fx", 1, n_bits, "int");
    n_bits = getminbitcountfornum(3);
    clientfield::register("vehicle", "veh_status_fx", 1, n_bits, "int");
    clientfield::register("actor", "keeper_fx", 1, 1, "int");
    clientfield::register("scriptmover", "item_glow_fx", 1, 3, "int");
    n_bits = getminbitcountfornum(7);
    clientfield::register("scriptmover", "shadowman_fx", 1, n_bits, "int");
    clientfield::register("world", "devgui_gateworm", 1, 1, "int");
    clientfield::register("scriptmover", "gateworm_basin_fx", 1, 2, "int");
    clientfield::register("world", "wallrun_footprints", 1, 2, "int");
    var_ab765abb = array("boxer", "detective", "femme", "magician");
    for (i = 0; i < 4; i++) {
        clientfield::register("toplayer", "check_" + var_ab765abb[i] + "_memento", 1, 1, "int");
    }
    level flag::init("keeper_sword_locker");
    n_bits = getminbitcountfornum(6);
    clientfield::register("toplayer", "used_quest_key", 1, n_bits, "int");
    clientfield::register("toplayer", "used_quest_key_location", 1, n_bits, "int");
    visionset_mgr::register_info("visionset", "zod_ritual_dim", 1, 1, 15, 1, &visionset_mgr::ramp_in_out_thread_per_player, 0);
    var_ab765abb = array("boxer", "detective", "femme", "magician");
    foreach (str_name in var_ab765abb) {
        var_62ef37c2 = getent("quest_ritual_relic_" + str_name + "_placed", "targetname");
        var_62ef37c2 ghost();
        a_e_clip = getentarray("ritual_clip_" + str_name, "targetname");
        foreach (e_clip in a_e_clip) {
            e_clip setinvisibletoall();
            e_clip.origin -= (0, 0, 128);
        }
    }
    a_e_clip = getentarray("ritual_clip_pap", "targetname");
    foreach (e_clip in a_e_clip) {
        e_clip setinvisibletoall();
        e_clip.origin -= (0, 0, 128);
    }
    level._effect["ritual_key_glow"] = "zombie/fx_ritual_glow_key_zod_zmb";
    level.var_3aa0c58 = 0;
    level.var_962b3ed4 = [];
    level.var_962b3ed4[0] = 20;
    level.var_962b3ed4[1] = 25;
    level.var_962b3ed4[2] = 30;
    level.var_962b3ed4[3] = 30;
    level.var_962b3ed4[4] = 30;
    level.var_4df5e1e7 = spawnstruct();
    level.var_4df5e1e7.var_3358c78c = 0;
    flag::init("quest_key_found");
    flag::init("memento_boxer_found");
    flag::init("memento_detective_found");
    flag::init("memento_femme_found");
    flag::init("memento_magician_found");
    flag::init("ritual_in_progress");
    flag::init("ritual_boxer_ready");
    flag::init("ritual_boxer_complete");
    flag::init("ritual_detective_ready");
    flag::init("ritual_detective_complete");
    flag::init("ritual_femme_ready");
    flag::init("ritual_femme_complete");
    flag::init("ritual_magician_ready");
    flag::init("ritual_magician_complete");
    flag::init("ritual_all_characters_complete");
    flag::init("pap_door_open");
    flag::init("pap_basin_1");
    flag::init("pap_basin_2");
    flag::init("pap_basin_3");
    flag::init("pap_basin_4");
    flag::init("pap_altar");
    flag::init("ritual_pap_ready");
    flag::init("ritual_pap_complete");
    flag::init("story_vo_playing");
    /#
        level thread quest_devgui();
    #/
}

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x1 linked
// Checksum 0x3036e93c, Offset: 0x2458
// Size: 0x1c
function on_player_connect() {
    self thread function_f7d960ba();
}

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x1 linked
// Checksum 0x2d8d0bf3, Offset: 0x2480
// Size: 0x46
function function_f7d960ba() {
    for (i = 0; i < 4; i++) {
        self thread function_70a7429b(i);
    }
}

// Namespace namespace_1f61c67f
// Params 1, eflags: 0x1 linked
// Checksum 0xec5e93fe, Offset: 0x24d0
// Size: 0x144
function function_70a7429b(var_25bc1c51) {
    self endon(#"disconnect");
    var_ab765abb = array("boxer", "detective", "femme", "magician");
    var_75ca3cc2 = struct::get("defend_area_" + var_ab765abb[var_25bc1c51], "targetname");
    var_33e67e27 = 0;
    while (isdefined(self)) {
        dist2 = distancesquared(self.origin, var_75ca3cc2.origin);
        var_f7225255 = dist2 < 4096;
        if (var_f7225255 != var_33e67e27) {
            self clientfield::set_to_player("check_" + var_ab765abb[var_25bc1c51] + "_memento", var_f7225255);
            var_33e67e27 = var_f7225255;
        }
        wait(0.1);
    }
}

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x1 linked
// Checksum 0xa9514938, Offset: 0x2620
// Size: 0x1c4
function function_f6527c1e() {
    callback::on_connect(&player_death_watcher);
    level flag::wait_till("start_zombie_round_logic");
    function_8ac925ef();
    level thread function_849636ef();
    level thread function_5148631e();
    level thread function_f64162f4();
    level thread function_6c19b4f1();
    level thread function_826b36fd();
    level thread function_83c8b6e8();
    level thread function_58fe842c();
    exploder::exploder("fx_exploder_magician_candles");
    level thread function_ffcfbd77();
    if (isdefined(level.gamedifficulty) && level.gamedifficulty != 0) {
    }
    if (isdefined(level.var_247a0fc6)) {
        level thread [[ level.var_247a0fc6 ]]();
    } else {
        level thread function_5761225();
    }
    if (isdefined(level.var_dac16b9a)) {
        level thread [[ level.var_dac16b9a ]]();
    } else {
        level thread function_45aff2d1();
    }
    namespace_6294c69f::function_ba281e3f();
}

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x1 linked
// Checksum 0x346498ab, Offset: 0x27f0
// Size: 0x64
function function_8ac925ef() {
    level flag::wait_till("initial_blackscreen_passed");
    mdl_key = getent("quest_key_pickup", "targetname");
    mdl_key ghost();
}

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x1 linked
// Checksum 0xa8f7103f, Offset: 0x2860
// Size: 0xfa
function function_ffcfbd77() {
    var_8b8460d5 = array("fuse_01", "fuse_02", "fuse_03");
    foreach (var_64f2aa7a in var_8b8460d5) {
        var_f2ae2c72 = level namespace_f37770c8::function_1f5d26ed("police_box", var_64f2aa7a);
        var_f2ae2c72 clientfield::set("item_glow_fx", 4);
    }
}

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x1 linked
// Checksum 0x39af3ff6, Offset: 0x2968
// Size: 0xbc
function function_849636ef() {
    mdl_key = getent("quest_key_pickup", "targetname");
    mdl_key show();
    mdl_key useanimtree(#generic);
    mdl_key clientfield::set("item_glow_fx", 1);
    function_1e9a18ce(mdl_key);
    mdl_key animation::play("p7_fxanim_zm_zod_summoning_key_idle_anim");
}

// Namespace namespace_1f61c67f
// Params 1, eflags: 0x1 linked
// Checksum 0x718de5a8, Offset: 0x2a30
// Size: 0x1b4
function function_1e9a18ce(mdl_key) {
    width = -128;
    height = -128;
    length = -128;
    mdl_key.unitrigger_stub = spawnstruct();
    mdl_key.unitrigger_stub.origin = mdl_key.origin;
    mdl_key.unitrigger_stub.angles = mdl_key.angles;
    mdl_key.unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    mdl_key.unitrigger_stub.cursor_hint = "HINT_NOICON";
    mdl_key.unitrigger_stub.script_width = width;
    mdl_key.unitrigger_stub.script_height = height;
    mdl_key.unitrigger_stub.script_length = length;
    mdl_key.unitrigger_stub.require_look_at = 0;
    mdl_key.unitrigger_stub.mdl_key = mdl_key;
    mdl_key.unitrigger_stub.prompt_and_visibility_func = &function_8f16bf43;
    zm_unitrigger::register_static_unitrigger(mdl_key.unitrigger_stub, &function_77878365);
}

// Namespace namespace_1f61c67f
// Params 1, eflags: 0x1 linked
// Checksum 0x99ec780b, Offset: 0x2bf0
// Size: 0x9a
function function_8f16bf43(player) {
    b_is_invis = isdefined(player.beastmode) && player.beastmode || !(isdefined(level.var_c913a45f) && level.var_c913a45f);
    self setinvisibletoplayer(player, b_is_invis);
    self sethintstring(%ZM_ZOD_QUEST_RITUAL_PICKUP_QUEST_KEY);
    return !b_is_invis;
}

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x1 linked
// Checksum 0x34ac52, Offset: 0x2c98
// Size: 0xd4
function function_77878365() {
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
        player playsound("zmb_zod_key_pickup");
        player thread namespace_b8707f8e::function_53b96c8f();
        level thread function_7d4c5423(self.stub);
        break;
    }
}

// Namespace namespace_1f61c67f
// Params 1, eflags: 0x1 linked
// Checksum 0xc4e089ec, Offset: 0x2d78
// Size: 0x154
function function_7d4c5423(var_91089b66) {
    var_91089b66.mdl_key ghost();
    level.var_c913a45f = 0;
    players = level.players;
    foreach (player in players) {
        if (zm_utility::is_player_valid(player)) {
            player thread namespace_8e578893::function_55f114f9("zmInventory.widget_quest_items", 3.5);
            player thread namespace_8e578893::function_69e0fb83("ZM_ZOD_UI_SUMMONING_KEY_PICKUP", 3.5);
        }
    }
    function_dc210153(1);
    var_91089b66 zm_unitrigger::run_visibility_function_for_all_triggers();
}

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x1 linked
// Checksum 0x1f709fba, Offset: 0x2ed8
// Size: 0x64
function function_5148631e() {
    level thread function_661aecc();
    level thread function_acc8367d();
    level thread function_fb535224();
    level thread function_af9ab682();
}

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x1 linked
// Checksum 0x32559ff8, Offset: 0x2f48
// Size: 0x64
function function_661aecc() {
    level flag::wait_till("power_on" + 20);
    level clientfield::set("junction_crane_state", 1);
    wait(9.5);
    function_c2c28545("memento_magician_drop");
}

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x1 linked
// Checksum 0xb00f9a17, Offset: 0x2fb8
// Size: 0xfa
function function_acc8367d() {
    a_e_door = getentarray("quest_personal_item_canal_door", "targetname");
    level flag::wait_till("power_on" + 23);
    foreach (e_door in a_e_door) {
        e_door moveto(e_door.origin - (0, 0, 64), 1);
    }
}

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x1 linked
// Checksum 0x7a1a4c68, Offset: 0x30c0
// Size: 0x144
function function_af9ab682() {
    level flag::wait_till("power_on" + 21);
    var_8c7e827f = getent("deco_door_left", "targetname");
    var_5548791a = getent("deco_door_right", "targetname");
    e_door_clip = getent("deco_door_clip", "targetname");
    var_8c7e827f rotateyaw(-121, 3);
    var_5548791a rotateyaw(-135, 3);
    e_door_clip connectpaths();
    e_door_clip delete();
    level flag::set("connect_theater_to_burlesque");
}

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x1 linked
// Checksum 0x13d3f190, Offset: 0x3210
// Size: 0x134
function function_fb535224() {
    e_door = getent("keeper_sword_locker", "targetname");
    e_door_clip = getent("keeper_sword_locker_clip", "targetname");
    e_door clientfield::set("set_subway_wall_dissolve", 1);
    level flag::wait_till("keeper_sword_locker");
    e_door clientfield::set("set_subway_wall_dissolve", 0);
    wait(2);
    e_door_clip connectpaths();
    e_door_clip delete();
    [[ level.var_ca7eab3b ]]->function_5b0296e8(1);
    wait(4);
    e_door delete();
}

// Namespace namespace_1f61c67f
// Params 1, eflags: 0x1 linked
// Checksum 0x1a367952, Offset: 0x3350
// Size: 0x224
function function_c2c28545(str_id) {
    var_4e9bc93a = getent(str_id + "_phrase", "targetname");
    if (isdefined(var_4e9bc93a)) {
        var_4e9bc93a delete();
    }
    var_3624589d = namespace_4624f91a::function_836451f4(str_id);
    n_wait_time = 0;
    switch (var_3624589d) {
    case 42:
        n_wait_time = 3;
        break;
    case 40:
        n_wait_time = 2.75;
        break;
    case 41:
        n_wait_time = 0.1;
        break;
    }
    wait(n_wait_time);
    mdl_relic = level namespace_f37770c8::function_1f5d26ed("ritual_" + var_3624589d, "memento_" + var_3624589d);
    mdl_relic clientfield::set("set_fade_material", 1);
    var_db42e573 = struct::get(str_id + "_point", "targetname");
    mdl_relic.origin = var_db42e573.origin;
    mdl_relic.angles = var_db42e573.angles;
    mdl_relic setvisibletoall();
    mdl_relic showindemo();
    mdl_relic clientfield::set("item_glow_fx", 3);
    function_984725d6(var_3624589d);
}

// Namespace namespace_1f61c67f
// Params 1, eflags: 0x1 linked
// Checksum 0xe0095362, Offset: 0x3580
// Size: 0x2b4
function function_984725d6(str_name) {
    var_d16bd3a3 = getent("ritual_zombie_spawner", "targetname");
    level flag::wait_till("memento_" + str_name + "_found");
    if (level.var_a80c1a9a !== 1) {
        level.var_a80c1a9a = 0;
    }
    wait(0.25);
    var_def860b4 = function_b4c88128(str_name);
    var_def860b4--;
    function_12370901("keeper_spawn_portals", var_def860b4, 1);
    wait(2.5);
    var_8bfb9994 = struct::get_array("memento_spawn_point_" + str_name);
    level thread namespace_b8707f8e::function_bcf7d3ea(var_8bfb9994);
    var_4480cf29 = [];
    foreach (s_spawn_point in var_8bfb9994) {
        ai = zombie_utility::spawn_zombie(var_d16bd3a3, "memento_keeper_zombie", s_spawn_point);
        if (isdefined(ai)) {
            ai thread function_2d0c5aa1(s_spawn_point);
            ai.custom_location = &function_411c908f;
            if (!isdefined(var_4480cf29)) {
                var_4480cf29 = [];
            } else if (!isarray(var_4480cf29)) {
                var_4480cf29 = array(var_4480cf29);
            }
            var_4480cf29[var_4480cf29.size] = ai;
        }
        wait(0.05);
    }
    if (!level.var_a80c1a9a) {
        thread function_7965975d(var_4480cf29);
    }
    wait(3);
    function_12370901("keeper_spawn_portals", var_def860b4, 0);
}

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x1 linked
// Checksum 0x8fd196e9, Offset: 0x3840
// Size: 0x2c2
function function_58fe842c() {
    e_spawner = getent("ritual_zombie_spawner", "targetname");
    var_eb09d2ff = getent("keeper_subway_welcome", "targetname");
    for (b_triggered = 0; !b_triggered; b_triggered = 1) {
        e_triggerer = var_eb09d2ff waittill(#"trigger");
        if (zm_utility::is_player_valid(e_triggerer) && !(isdefined(e_triggerer.beastmode) && e_triggerer.beastmode)) {
            level clientfield::set("keeper_subway_fx", 1);
            wait(2.5);
            var_8bfb9994 = struct::get_array("keeper_spawn_point_subway");
            level thread namespace_b8707f8e::function_bcf7d3ea(var_8bfb9994);
            var_4480cf29 = [];
            foreach (s_spawn_point in var_8bfb9994) {
                ai = zombie_utility::spawn_zombie(e_spawner, "memento_keeper_zombie", s_spawn_point);
                if (isdefined(ai)) {
                    ai thread function_2d0c5aa1(s_spawn_point);
                    ai.custom_location = &function_411c908f;
                    if (!isdefined(var_4480cf29)) {
                        var_4480cf29 = [];
                    } else if (!isarray(var_4480cf29)) {
                        var_4480cf29 = array(var_4480cf29);
                    }
                    var_4480cf29[var_4480cf29.size] = ai;
                }
                wait(0.05);
            }
            wait(3);
            level clientfield::set("keeper_subway_fx", 0);
        }
    }
}

// Namespace namespace_1f61c67f
// Params 1, eflags: 0x1 linked
// Checksum 0xc565942c, Offset: 0x3b10
// Size: 0xce
function function_7965975d(var_553a9d46) {
    self endon(#"_zombie_game_over");
    level endon(#"hash_2403fc5b");
    while (var_553a9d46.size > 0) {
        for (i = 0; i < var_553a9d46.size; i++) {
            if (!isalive(var_553a9d46[i])) {
                arrayremovevalue(var_553a9d46, var_553a9d46[i]);
            }
        }
        wait(0.05);
    }
    thread namespace_b8707f8e::function_93f0e7bd();
    level.var_a80c1a9a = 1;
    level notify(#"hash_2403fc5b");
}

// Namespace namespace_1f61c67f
// Params 3, eflags: 0x1 linked
// Checksum 0x90e2bca4, Offset: 0x3be8
// Size: 0x94
function function_12370901(var_3d4e0762, var_def860b4, b_on) {
    n_val = level clientfield::get(var_3d4e0762);
    if (b_on) {
        n_val |= 1 << var_def860b4;
    } else {
        n_val &= !(1 << var_def860b4);
    }
    level clientfield::set(var_3d4e0762, n_val);
}

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x3c88
// Size: 0x4
function function_411c908f() {
    
}

// Namespace namespace_1f61c67f
// Params 1, eflags: 0x1 linked
// Checksum 0xf8af291b, Offset: 0x3c98
// Size: 0x284
function function_2d0c5aa1(s_spawn_point) {
    self endon(#"death");
    self.script_string = "find_flesh";
    self setphysparams(15, 0, 72);
    self.ignore_enemy_count = 1;
    self.no_eye_glow = 1;
    self.deathpoints_already_given = 1;
    self.var_8ac75273 = 1;
    self.exclude_cleanup_adding_to_total = 1;
    util::wait_network_frame();
    self clientfield::set("keeper_fx", 1);
    level thread function_efbd4abf(self, s_spawn_point);
    self.voiceprefix = "keeper";
    if (self.zombie_move_speed === "walk") {
        self zombie_utility::set_zombie_run_cycle("run");
    }
    find_flesh_struct_string = "find_flesh";
    self notify(#"zombie_custom_think_done", find_flesh_struct_string);
    self.variant_type = randomint(4);
    self.nocrawler = 1;
    self.zm_variant_type_max = [];
    self.zm_variant_type_max["walk"] = [];
    self.zm_variant_type_max["run"] = [];
    self.zm_variant_type_max["sprint"] = [];
    self.zm_variant_type_max["walk"]["down"] = 4;
    self.zm_variant_type_max["walk"]["up"] = 4;
    self.zm_variant_type_max["run"]["down"] = 4;
    self.zm_variant_type_max["run"]["up"] = 4;
    self.zm_variant_type_max["sprint"]["down"] = 4;
    self.zm_variant_type_max["sprint"]["up"] = 4;
    self waittill(#"completed_emerging_into_playable_area");
    self.no_powerups = 1;
}

// Namespace namespace_1f61c67f
// Params 2, eflags: 0x1 linked
// Checksum 0xeae583bd, Offset: 0x3f28
// Size: 0xa4
function function_efbd4abf(ai_zombie, s_spawn_point) {
    ai_zombie waittill(#"death");
    if (isdefined(ai_zombie)) {
        ai_zombie clientfield::set("keeper_fx", 0);
    }
    if (isdefined(s_spawn_point.var_e93843aa)) {
        s_spawn_point.var_e93843aa--;
    }
    util::wait_network_frame();
    if (isdefined(ai_zombie)) {
        ai_zombie delete();
    }
}

// Namespace namespace_1f61c67f
// Params 1, eflags: 0x1 linked
// Checksum 0xde3df312, Offset: 0x3fd8
// Size: 0x56
function function_b4c88128(str_name) {
    switch (str_name) {
    case 42:
        return 1;
    case 41:
        return 2;
    case 40:
        return 3;
    case 39:
        return 4;
    }
}

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x1 linked
// Checksum 0xcbb14295, Offset: 0x4038
// Size: 0x2f0
function function_f64162f4() {
    assert(!isdefined(level.var_c0091dc4), "ritual_progress");
    level.var_c0091dc4 = [];
    var_ab765abb = array("boxer", "detective", "femme", "magician");
    foreach (str_name in var_ab765abb) {
        function_1b8f72e5(str_name);
    }
    var_20f219b1 = getentarray("ritual_zombie_spawner", "targetname");
    array::thread_all(var_20f219b1, &spawner::add_spawn_function, &zm_spawner::zombie_spawn_init);
    level.var_c0091dc4["pap"] = new class_a0023ae3();
    [[ level.var_c0091dc4["pap"] ]]->init("defend_area_" + "pap", "defend_area_spawn_point_" + "pap");
    [[ level.var_c0091dc4["pap"] ]]->function_5b8cdc04("ZodRitualProgress", "ZodRitualReturn", "ZodRitualSucceeded", "ZodRitualFailed");
    [[ level.var_c0091dc4["pap"] ]]->function_ebd4e698(&function_5e697f41);
    [[ level.var_c0091dc4["pap"] ]]->function_4cc0ffc1(&function_7dde76aa, &function_79c39bdd, &function_96a27419, &function_a9f5d007, "pap");
    [[ level.var_c0091dc4["pap"] ]]->function_b9dda40b("defend_area_volume_" + "pap", "defend_area_volume_" + "pap");
    [[ level.var_c0091dc4["pap"] ]]->start();
}

// Namespace namespace_1f61c67f
// Params 1, eflags: 0x1 linked
// Checksum 0xcf75dca4, Offset: 0x4330
// Size: 0x158
function function_1b8f72e5(str_name) {
    assert(!isdefined(level.var_c0091dc4[str_name]), "ritual_progress");
    level.var_c0091dc4[str_name] = new class_a0023ae3();
    [[ level.var_c0091dc4[str_name] ]]->init("defend_area_" + str_name, "defend_area_spawn_point_" + str_name);
    [[ level.var_c0091dc4[str_name] ]]->function_5b8cdc04("ZodRitualProgress", "ZodRitualReturn", "ZodRitualSucceeded", "ZodRitualFailed");
    [[ level.var_c0091dc4[str_name] ]]->function_4cc0ffc1(&function_7dde76aa, &function_79c39bdd, &function_96a27419, &function_a9f5d007, str_name);
    [[ level.var_c0091dc4[str_name] ]]->function_b9dda40b("defend_area_volume_" + str_name, "defend_area_volume_" + str_name);
}

// Namespace namespace_1f61c67f
// Params 1, eflags: 0x1 linked
// Checksum 0x17815112, Offset: 0x4490
// Size: 0xc
function function_b35b6cb3(state) {
    
}

// Namespace namespace_1f61c67f
// Params 1, eflags: 0x1 linked
// Checksum 0x6d0622b1, Offset: 0x44a8
// Size: 0x11e
function function_dc210153(var_a7e88950) {
    level clientfield::set("quest_key", var_a7e88950);
    foreach (var_501122d5 in level.var_c0091dc4) {
        thread [[ var_501122d5 ]]->function_a7fe9183(var_a7e88950);
    }
    if (var_a7e88950) {
        players = level.players;
        for (i = 0; i < players.size; i++) {
            players[i] clientfield::set_to_player("used_quest_key", 0);
        }
    }
}

// Namespace namespace_1f61c67f
// Params 1, eflags: 0x1 linked
// Checksum 0xc6e973c, Offset: 0x45d0
// Size: 0x18a
function function_7dde76aa(str_name) {
    if (str_name === "pap") {
        var_c962aefb = array("pap_basin_1", "pap_basin_2", "pap_basin_3", "pap_basin_4");
        foreach (var_c8d6ad34 in var_c962aefb) {
            if (!level flag::get(var_c8d6ad34)) {
                return 0;
            }
        }
        return 1;
    }
    var_cd27378f = level clientfield::get("quest_key");
    if (level clientfield::get("ritual_state_" + str_name) == 2) {
        var_56033cd2 = 1;
    } else {
        var_56033cd2 = 0;
    }
    if (var_cd27378f && !var_56033cd2 || var_56033cd2) {
        return 1;
    }
    return 0;
}

// Namespace namespace_1f61c67f
// Params 2, eflags: 0x1 linked
// Checksum 0xeda7431a, Offset: 0x4768
// Size: 0x4c4
function function_79c39bdd(str_name, e_triggerer) {
    level notify("ritual_" + str_name + "_start");
    level flag::clear("zombie_drop_powerups");
    level flag::set("ritual_in_progress");
    level flag::clear("can_spawn_margwa");
    if (str_name === "pap") {
        level.var_e33804d4 = 1;
        level.var_f15a9a7a = 1;
        mdl_key = getent("quest_key_pickup", "targetname");
        s_altar = struct::get("defend_area_pap", "targetname");
        mdl_key.origin = s_altar.origin;
        mdl_key show();
        mdl_key clientfield::set("item_glow_fx", 1);
        mdl_key thread animation::play("p7_fxanim_zm_zod_summoning_key_idle_anim");
        exploder::exploder("fx_exploder_ritual_pap_altar_path");
        level.musicsystemoverride = 1;
        music::setmusicstate("zod_final_ritual");
    } else {
        level.var_9bc9c61f = str_name;
        level thread namespace_b8707f8e::function_658d89a3(str_name);
    }
    function_dc210153(0);
    switch (str_name) {
    case 42:
        var_f34eee69 = 1;
        break;
    case 41:
        var_f34eee69 = 2;
        break;
    case 40:
        var_f34eee69 = 3;
        break;
    case 39:
        var_f34eee69 = 4;
        break;
    case 121:
        var_f34eee69 = 5;
        break;
    }
    e_triggerer clientfield::set_to_player("used_quest_key_location", var_f34eee69);
    var_e85b4e8 = 0;
    switch (e_triggerer.characterindex) {
    case 0:
        var_e85b4e8 = 1;
        break;
    case 1:
        var_e85b4e8 = 2;
        break;
    case 2:
        var_e85b4e8 = 3;
        break;
    case 3:
        var_e85b4e8 = 4;
        break;
    }
    foreach (player in level.players) {
        player clientfield::set_to_player("used_quest_key", var_e85b4e8);
        player recordmapevent(21, gettime(), player.origin, level.round_number, var_f34eee69);
    }
    level clientfield::set("ritual_state_" + str_name, 2);
    level clientfield::set("ritual_current", function_1c84e806(str_name));
    function_ee08dafb(str_name, 1);
    n_duration = level.var_962b3ed4[level.var_3aa0c58];
    var_b55bd3d0 = [[ level.var_c0091dc4[str_name] ]]->function_27323b36(n_duration);
    level thread function_2d12aef1(str_name);
}

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x1 linked
// Checksum 0x7489471e, Offset: 0x4c38
// Size: 0x10e
function function_6cba21ae() {
    var_59e0351b = level clientfield::get("ritual_current");
    foreach (player in level.players) {
        player recordmapevent(22, gettime(), player.origin, level.round_number, var_59e0351b);
    }
    level clientfield::set("ritual_current", 0);
    level.var_8280ab5f = level.var_9bc9c61f;
    level.var_9bc9c61f = undefined;
}

// Namespace namespace_1f61c67f
// Params 1, eflags: 0x1 linked
// Checksum 0xe90db769, Offset: 0x4d50
// Size: 0x29c
function function_2d12aef1(str_name) {
    var_bfb1dae2 = "ritual_" + str_name + "_succeed";
    var_d135f7ae = "ritual_" + str_name + "_fail";
    level endon(var_bfb1dae2);
    level endon(var_d135f7ae);
    level thread function_cc04ada(var_bfb1dae2, var_d135f7ae);
    var_9e663a06 = 0;
    var_c468b46f = 0;
    var_52614534 = 0;
    var_7863bf9d = 0;
    var_8df092ed = function_5e98a0b6(str_name);
    while (true) {
        var_b55bd3d0 = [[ level.var_c0091dc4[str_name] ]]->function_4721f0d();
        var_b55bd3d0 = float(var_b55bd3d0);
        println("ritual_progress" + var_b55bd3d0);
        level clientfield::set("ritual_progress", var_b55bd3d0);
        if (var_b55bd3d0 >= 0.2 && var_b55bd3d0 < 0.45 && !var_9e663a06) {
            var_9e663a06 = namespace_b8707f8e::function_335f3a81(0, var_8df092ed);
        } else if (var_b55bd3d0 >= 0.45 && var_b55bd3d0 < 0.7 && !var_c468b46f) {
            var_c468b46f = namespace_b8707f8e::function_335f3a81(1, var_8df092ed);
        } else if (var_b55bd3d0 >= 0.7 && var_b55bd3d0 < 0.9 && !var_52614534) {
            var_52614534 = namespace_b8707f8e::function_335f3a81(2, var_8df092ed);
        } else if (var_b55bd3d0 >= 0.9 && !var_7863bf9d) {
            var_7863bf9d = namespace_b8707f8e::function_335f3a81(3, var_8df092ed);
        }
        wait(0.05);
    }
}

// Namespace namespace_1f61c67f
// Params 2, eflags: 0x1 linked
// Checksum 0xd59c115e, Offset: 0x4ff8
// Size: 0x48
function function_cc04ada(var_bfb1dae2, var_d135f7ae) {
    level.no_powerups = 1;
    level util::waittill_any(var_bfb1dae2, var_d135f7ae);
    level.no_powerups = 0;
}

// Namespace namespace_1f61c67f
// Params 1, eflags: 0x1 linked
// Checksum 0x5d99bd01, Offset: 0x5048
// Size: 0x14a
function function_5e98a0b6(str_name) {
    switch (str_name) {
    case 42:
        var_8f06ff9 = 0;
        break;
    case 41:
        var_8f06ff9 = 1;
        break;
    case 40:
        var_8f06ff9 = 2;
        break;
    case 39:
        var_8f06ff9 = 3;
        break;
    case 121:
        return false;
    }
    foreach (e_player in level.players) {
        var_8df092ed = [[ level.var_c0091dc4[str_name] ]]->function_1a94b9be(e_player);
        if (var_8df092ed && e_player.characterindex == var_8f06ff9) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_1f61c67f
// Params 2, eflags: 0x1 linked
// Checksum 0x23a1cc8b, Offset: 0x51a0
// Size: 0x33c
function function_96a27419(str_name, var_6ec814a1) {
    level.var_3aa0c58++;
    level flag::set("zombie_drop_powerups");
    level flag::clear("ritual_in_progress");
    function_ee08dafb(str_name, 0);
    if (str_name == "pap") {
        music::setmusicstate("none");
        level.musicsystemoverride = 0;
        exploder::stop_exploder("fx_exploder_ritual_pap_altar_path");
        function_8ff18033();
        return;
    }
    /#
        if (!isdefined(var_6ec814a1)) {
            var_6ec814a1 = level.activeplayers;
        }
    #/
    function_6cba21ae();
    level thread function_b600b7f6(str_name);
    level notify("ritual_" + str_name + "_succeed");
    level flag::set("ritual_" + str_name + "_complete");
    level clientfield::set("ritual_state_" + str_name, 3);
    level clientfield::set("quest_state_" + str_name, 3);
    wait(getanimlength("p7_fxanim_zm_zod_redemption_key_ritual_end_anim"));
    if (str_name === "magician") {
        exploder::stop_exploder("fx_exploder_magician_candles");
        hidemiscmodels("ritual_candles_" + str_name + "_on");
        showmiscmodels("ritual_candles_" + str_name + "_off");
    }
    mdl_relic = level namespace_f37770c8::function_1f5d26ed("ritual_pap", "relic_" + str_name);
    if (isdefined(mdl_relic)) {
        mdl_relic setinvisibletoall();
        var_db42e573 = struct::get("quest_ritual_item_placed_" + str_name, "targetname");
        mdl_relic.origin = var_db42e573.origin;
        mdl_relic clientfield::set("item_glow_fx", 2);
    }
    level thread namespace_b8707f8e::function_17f92643();
    function_dc210153(1);
}

// Namespace namespace_1f61c67f
// Params 1, eflags: 0x1 linked
// Checksum 0xa32c2037, Offset: 0x54e8
// Size: 0xec
function function_b600b7f6(str_name) {
    wait(10);
    if (level.var_3aa0c58 == 2 || level.var_3aa0c58 == 4 || level.var_3aa0c58 == 5) {
        var_7ee78287 = struct::get("defend_area_" + str_name, "targetname");
        var_5fb1e746 = arraygetclosest(var_7ee78287.origin, level.var_95810297);
        if (level.var_6e63e659 == 0) {
            namespace_d17e1da0::function_8bcb72e9(0, var_5fb1e746);
        }
    }
    level flag::set("can_spawn_margwa");
}

// Namespace namespace_1f61c67f
// Params 1, eflags: 0x1 linked
// Checksum 0x734c1520, Offset: 0x55e0
// Size: 0x1bc
function function_a9f5d007(str_name) {
    level flag::set("zombie_drop_powerups");
    level flag::clear("ritual_in_progress");
    function_ee08dafb(str_name, 0);
    if (str_name == "pap") {
        music::setmusicstate("none");
        level.musicsystemoverride = 0;
        exploder::stop_exploder("fx_exploder_ritual_pap_altar_path");
        function_1c56b1d();
    }
    function_dc210153(1);
    level notify("ritual_" + str_name + "_fail");
    level clientfield::set("ritual_progress", 0);
    wait(1);
    level clientfield::set("ritual_current", 0);
    level clientfield::set("ritual_state_" + str_name, 1);
    if (str_name != "pap") {
        level clientfield::set("quest_state_" + str_name, 3);
    }
    level flag::set("can_spawn_margwa");
}

// Namespace namespace_1f61c67f
// Params 2, eflags: 0x1 linked
// Checksum 0x4b9eb299, Offset: 0x57a8
// Size: 0x19a
function function_ee08dafb(str_name, b_on) {
    a_e_clip = getentarray("ritual_clip_" + str_name, "targetname");
    foreach (e_clip in a_e_clip) {
        if (b_on) {
            e_clip.origin += (0, 0, 128);
            e_clip setvisibletoall();
            exploder::exploder("fx_exploder_ritual_" + str_name + "_barrier");
            continue;
        }
        e_clip.origin -= (0, 0, 128);
        e_clip setinvisibletoall();
        exploder::stop_exploder("fx_exploder_ritual_" + str_name + "_barrier");
    }
}

// Namespace namespace_1f61c67f
// Params 1, eflags: 0x1 linked
// Checksum 0x8a554c16, Offset: 0x5950
// Size: 0x64
function function_1c84e806(str_name) {
    switch (str_name) {
    case 42:
        return 1;
    case 41:
        return 2;
    case 40:
        return 3;
    case 39:
        return 4;
    case 121:
        return 5;
    }
    return 0;
}

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x1 linked
// Checksum 0xcd8609de, Offset: 0x59c0
// Size: 0x454
function function_8ff18033() {
    exploder::exploder("fx_exploder_ritual_gatestone_explosion");
    exploder::exploder("fx_exploder_ritual_gatestone_portal");
    for (i = 1; i < 5; i++) {
        exploder::stop_exploder("fx_exploder_ritual_pap_basin_" + i + "_path");
        var_2c61a23c = function_cabbbee5("pap_basin_" + i);
        var_2c61a23c clientfield::set("gateworm_basin_fx", 2);
        var_2c61a23c playloopsound("zmb_zod_ritual_pap_worm_firelvl2", 1);
    }
    var_b7d2bed = array("relic_boxer", "relic_detective", "relic_femme", "relic_magician");
    foreach (var_a1b4f9cd in var_b7d2bed) {
        var_5ff9a2f5 = getent("quest_ritual_" + var_a1b4f9cd + "_placed", "targetname");
        var_5ff9a2f5 movez(64, 3);
        var_5ff9a2f5 rotateyaw(-76, 3);
    }
    level notify(#"hash_8ff18033");
    level flag::set("ritual_pap_complete");
    hidemiscmodels("gatestone_unbroken");
    level clientfield::set("ritual_current", 0);
    level clientfield::set("ritual_state_pap", 3);
    for (i = 1; i < 5; i++) {
        if (isdefined(level.var_f86952c7["pap_basin_" + i])) {
            zm_unitrigger::unregister_unitrigger(level.var_f86952c7["pap_basin_" + i]);
        }
    }
    function_a6838c4f();
    level thread namespace_b8707f8e::function_edca6dc9();
    level util::waittill_any_timeout(20, "vo_ritual_pap_succeed_done");
    level thread function_b600b7f6("pap");
    /#
        var_4c4fcdb0 = array("ritual_progress", "ritual_progress", "ritual_progress", "ritual_progress");
        foreach (var_83f1459 in var_4c4fcdb0) {
            level flag::set(var_83f1459);
        }
        level flag::set("ritual_progress");
    #/
}

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x1 linked
// Checksum 0x99732e6f, Offset: 0x5e20
// Size: 0x40
function function_1c56b1d() {
    level notify(#"hash_1c56b1d");
    level clientfield::set("ritual_current", 0);
    level.var_f15a9a7a = 0;
}

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x0
// Checksum 0x6a6df4ad, Offset: 0x5e68
// Size: 0xb8
function function_7133b4dd() {
    var_fe8368d2 = 0;
    if (flag::get("ritual_boxer_complete")) {
        var_fe8368d2++;
    }
    if (flag::get("ritual_detective_complete")) {
        var_fe8368d2++;
    }
    if (flag::get("ritual_femme_complete")) {
        var_fe8368d2++;
    }
    if (flag::get("ritual_magician_complete")) {
        var_fe8368d2++;
    }
    if (flag::get("ritual_pap_complete")) {
        var_fe8368d2++;
    }
    return var_fe8368d2;
}

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x1 linked
// Checksum 0x7b8cb3b0, Offset: 0x5f28
// Size: 0x434
function function_6c19b4f1() {
    e_pap_door = getent("pap_door", "targetname");
    var_a31f9f88 = getent("e_pap_door_brick_chunk1", "targetname");
    var_15270ec3 = getent("e_pap_door_brick_chunk2", "targetname");
    var_f8aa4aac = getent("pap_door_clip", "targetname");
    var_a31f9f88 thread clientfield::set("set_subway_wall_dissolve", 1);
    var_15270ec3 thread clientfield::set("set_subway_wall_dissolve", 1);
    e_pap_door hidepart("tag_ritual_key_on");
    e_pap_door showpart("tag_ritual_key_off");
    exploder::exploder("fx_exploder_ritual_pap_wall_smk");
    var_ab765abb = array("boxer", "detective", "femme", "magician");
    foreach (str_name in var_ab765abb) {
        e_pap_door thread function_88f2c3b3(str_name);
    }
    var_4c4fcdb0 = array("ritual_boxer_complete", "ritual_detective_complete", "ritual_femme_complete", "ritual_magician_complete");
    level flag::wait_till_all(var_4c4fcdb0);
    flag::set("ritual_all_characters_complete");
    e_pap_door showpart("tag_ritual_key_on");
    e_pap_door hidepart("tag_ritual_key_off");
    level thread function_b145d97b();
    level flag::wait_till("pap_door_open");
    e_pap_door setinvisibletoall();
    e_pap_door playsound("zmb_zod_pap_wall_explode");
    exploder::exploder("fx_exploder_ritual_pap_wall_explo");
    var_a31f9f88 thread clientfield::set("set_subway_wall_dissolve", 0);
    var_15270ec3 thread clientfield::set("set_subway_wall_dissolve", 0);
    wait(3.5);
    var_f8aa4aac connectpaths();
    e_pap_door delete();
    var_f8aa4aac delete();
    exploder::stop_exploder("fx_exploder_ritual_pap_wall_smk");
    var_a31f9f88 delete();
    var_15270ec3 delete();
}

// Namespace namespace_1f61c67f
// Params 1, eflags: 0x1 linked
// Checksum 0x7b88e5b7, Offset: 0x6368
// Size: 0x144
function function_88f2c3b3(str_name) {
    self hidepart("tag_ritual_" + str_name + "_on");
    self showpart("tag_ritual_" + str_name + "_off");
    level flag::wait_till("ritual_" + str_name + "_complete");
    self showpart("tag_ritual_" + str_name + "_on");
    self hidepart("tag_ritual_" + str_name + "_off");
    level flag::wait_till("pap_door_open");
    self hidepart("tag_ritual_" + str_name + "_on");
    self hidepart("tag_ritual_" + str_name + "_off");
}

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x1 linked
// Checksum 0xa38a1fe4, Offset: 0x64b8
// Size: 0x170
function function_b145d97b() {
    level notify(#"hash_b145d97b");
    level endon(#"hash_b145d97b");
    var_4c6fd588 = getent("pap_door_trigger", "targetname");
    while (true) {
        foreach (player in level.activeplayers) {
            if (zombie_utility::is_player_valid(player) && player istouching(var_4c6fd588)) {
                player namespace_8e578893::function_6edf48d5(5);
                wait(1);
                if (isdefined(player)) {
                    player namespace_8e578893::function_6edf48d5(0);
                }
                level flag::set("pap_door_open");
                return;
            }
        }
        wait(0.1);
    }
}

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x1 linked
// Checksum 0xa4005734, Offset: 0x6630
// Size: 0x1b4
function function_826b36fd() {
    level flag::wait_till("start_zombie_round_logic");
    hint_string = %ZM_ZOD_QUEST_RITUAL_NEED_RELIC;
    var_175bc9b5 = &function_9d4738a0;
    var_5a170a81 = &function_78efbdbc;
    for (i = 1; i < 5; i++) {
        function_1ade5082("pap_basin_" + i, hint_string, var_175bc9b5, var_5a170a81);
    }
    level thread function_2eacaa8(1, "pap_basin_1");
    level thread function_52d8dfb6(1, "pap_basin_2");
    level thread function_52d8dfb6(0, "pap_basin_3");
    level thread function_2eacaa8(0, "pap_basin_4");
    a_flags = array("pap_basin_2", "pap_basin_3");
    level thread function_cee28413(a_flags);
    level thread function_ae395e41(a_flags);
    level thread function_d6a52a8a();
}

// Namespace namespace_1f61c67f
// Params 4, eflags: 0x1 linked
// Checksum 0x5bb41f05, Offset: 0x67f0
// Size: 0x23a
function function_1ade5082(str_flag, hint_string, var_175bc9b5, var_5a170a81) {
    width = 110;
    height = 90;
    length = 110;
    var_6155e6b6 = struct::get(str_flag, "script_noteworthy");
    var_6155e6b6.unitrigger_stub = spawnstruct();
    var_6155e6b6.unitrigger_stub.origin = var_6155e6b6.origin;
    var_6155e6b6.unitrigger_stub.angles = var_6155e6b6.angles;
    var_6155e6b6.unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    var_6155e6b6.unitrigger_stub.hint_string = hint_string;
    var_6155e6b6.unitrigger_stub.cursor_hint = "HINT_NOICON";
    var_6155e6b6.unitrigger_stub.script_width = width;
    var_6155e6b6.unitrigger_stub.script_height = height;
    var_6155e6b6.unitrigger_stub.script_length = length;
    var_6155e6b6.unitrigger_stub.require_look_at = 0;
    var_6155e6b6.unitrigger_stub.str_flag = str_flag;
    var_6155e6b6.unitrigger_stub.prompt_and_visibility_func = var_175bc9b5;
    zm_unitrigger::register_static_unitrigger(var_6155e6b6.unitrigger_stub, var_5a170a81);
    if (!isdefined(level.var_f86952c7)) {
        level.var_f86952c7 = [];
    }
    level.var_f86952c7[str_flag] = var_6155e6b6.unitrigger_stub;
}

// Namespace namespace_1f61c67f
// Params 1, eflags: 0x1 linked
// Checksum 0xad0fc25c, Offset: 0x6a38
// Size: 0x112
function function_9d4738a0(player) {
    b_is_invis = isdefined(self.stub.var_c8a5b443) && (isdefined(player.beastmode) && player.beastmode || self.stub.var_c8a5b443);
    self setinvisibletoplayer(player, b_is_invis);
    if (zombie_utility::is_player_valid(player)) {
        var_a1b4f9cd = function_7839dceb();
    }
    if (isdefined(var_a1b4f9cd)) {
        self sethintstring(%ZM_ZOD_QUEST_RITUAL_PLACE_RELIC);
    } else {
        self sethintstring(self.stub.hint_string);
    }
    return !b_is_invis;
}

// Namespace namespace_1f61c67f
// Params 1, eflags: 0x1 linked
// Checksum 0xccd231c7, Offset: 0x6b58
// Size: 0x122
function function_5e697f41(player) {
    b_is_invis = isdefined(level.var_f15a9a7a) && (isdefined(player.beastmode) && player.beastmode || level.var_f15a9a7a) || level flag::get("ee_book");
    self setinvisibletoplayer(player, b_is_invis);
    var_6ad07f7a = function_6349599();
    if (!var_6ad07f7a) {
        if (isdefined(level.var_e33804d4)) {
            self sethintstring(%ZM_ZOD_QUEST_RITUAL_PAP_REPLACE);
        } else {
            self sethintstring(%ZM_ZOD_QUEST_RITUAL_PAP_NOT_READY);
        }
    } else {
        self sethintstring(%ZM_ZOD_QUEST_RITUAL_PAP_KICKOFF);
    }
    return !b_is_invis;
}

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x1 linked
// Checksum 0xa5420858, Offset: 0x6c88
// Size: 0x58
function function_6349599() {
    for (i = 1; i < 5; i++) {
        if (!level flag::get("pap_basin_" + i)) {
            return false;
        }
    }
    return true;
}

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x0
// Checksum 0xee3b6521, Offset: 0x6ce8
// Size: 0x4e
function function_f686f8c1() {
    for (i = 1; i < 5; i++) {
        level flag::clear("pap_basin_" + i);
    }
}

// Namespace namespace_1f61c67f
// Params 1, eflags: 0x0
// Checksum 0x70fd60c4, Offset: 0x6d40
// Size: 0x242
function function_3d200551(characterindex) {
    var_c1b36585 = level clientfield::get("quest_state_" + "boxer");
    var_b0ea880a = level clientfield::get("quest_state_" + "detective");
    var_fe8736a5 = level clientfield::get("quest_state_" + "femme");
    var_42afec46 = level clientfield::get("quest_state_" + "magician");
    var_d9975501 = level clientfield::get("holder_of_" + "boxer");
    var_a9f9431e = level clientfield::get("holder_of_" + "detective");
    var_7c357839 = level clientfield::get("holder_of_" + "femme");
    var_e99064e2 = level clientfield::get("holder_of_" + "magician");
    if (var_c1b36585 === 4 && var_d9975501 === characterindex + 1) {
        return "relic_boxer";
    }
    if (var_b0ea880a === 4 && var_a9f9431e === characterindex + 1) {
        return "relic_detective";
    }
    if (var_fe8736a5 === 4 && var_7c357839 === characterindex + 1) {
        return "relic_femme";
    }
    if (var_42afec46 === 4 && var_e99064e2 === characterindex + 1) {
        return "relic_magician";
    }
    return undefined;
}

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x1 linked
// Checksum 0xdac39f8f, Offset: 0x6f90
// Size: 0xa8
function function_7839dceb() {
    for (i = 1; i <= 4; i++) {
        var_d7e2a718 = function_d4c08457(i);
        var_a5fe74e4 = level clientfield::get("quest_state_" + var_d7e2a718);
        if (var_a5fe74e4 == 4) {
            return function_7130d103(i);
        }
    }
    return undefined;
}

// Namespace namespace_1f61c67f
// Params 1, eflags: 0x1 linked
// Checksum 0xbc1f9ed9, Offset: 0x7040
// Size: 0x5e
function function_d4c08457(n_character_index) {
    switch (n_character_index) {
    case 1:
        return "boxer";
    case 2:
        return "detective";
    case 3:
        return "femme";
    case 4:
        return "magician";
    }
}

// Namespace namespace_1f61c67f
// Params 1, eflags: 0x1 linked
// Checksum 0x8976e17f, Offset: 0x70a8
// Size: 0x5e
function function_7130d103(n_character_index) {
    switch (n_character_index) {
    case 1:
        return "relic_boxer";
    case 2:
        return "relic_detective";
    case 3:
        return "relic_femme";
    case 4:
        return "relic_magician";
    }
}

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x1 linked
// Checksum 0xc4191acf, Offset: 0x7110
// Size: 0x29c
function function_78efbdbc() {
    var_a1b4f9cd = undefined;
    while (!level flag::get("ritual_pap_complete")) {
        e_triggerer = self waittill(#"trigger");
        if (zombie_utility::is_player_valid(e_triggerer)) {
            var_a1b4f9cd = function_7839dceb();
        }
        if (isdefined(var_a1b4f9cd)) {
            self.stub.var_c8a5b443 = 1;
            self.stub zm_unitrigger::run_visibility_function_for_all_triggers();
            str_flag = self.stub.str_flag;
            level flag::set(str_flag);
            function_5eb042a7(str_flag, var_a1b4f9cd, 1);
            e_triggerer thread namespace_8e578893::function_6edf48d5(6, 1);
            earthquake(0.35, 0.3, e_triggerer.origin, -106);
            e_triggerer thread namespace_b8707f8e::function_24b80509();
            level clientfield::set("holder_of_" + namespace_4624f91a::function_836451f4(var_a1b4f9cd), 0);
            e_triggerer namespace_f37770c8::function_95ab081("ritual_pap", "relic_" + namespace_4624f91a::function_836451f4(var_a1b4f9cd));
            level clientfield::set("quest_state_" + namespace_4624f91a::function_836451f4(var_a1b4f9cd), 5);
            if (function_6349599()) {
                self playsound("zmb_zod_ritual_pap_worm_place_final");
            } else {
                self playsound("zmb_zod_ritual_pap_worm_place");
            }
            level thread zm_unitrigger::unregister_unitrigger(self.stub);
            return;
        }
        wait(0.05);
    }
}

// Namespace namespace_1f61c67f
// Params 3, eflags: 0x1 linked
// Checksum 0x93376628, Offset: 0x73b8
// Size: 0x1fc
function function_5eb042a7(str_flag, var_a1b4f9cd, b_is_active) {
    var_5ff9a2f5 = getent("quest_ritual_" + var_a1b4f9cd + "_placed", "targetname");
    if (b_is_active) {
        var_2c61a23c = function_cabbbee5(str_flag);
        var_16e322eb = str_flag + "_pos";
        var_8835d08c = struct::get(var_16e322eb, "targetname");
        if (isdefined(var_8835d08c)) {
            var_5ff9a2f5.origin = var_8835d08c.origin;
            var_5ff9a2f5.angles = var_8835d08c.angles;
        } else {
            var_5ff9a2f5.origin = var_2c61a23c.origin + (0, 0, 40);
        }
        var_5ff9a2f5 show();
        var_5ff9a2f5 playloopsound("zmb_zod_ritual_worm_lp");
        var_2c61a23c clientfield::set("gateworm_basin_fx", 1);
        var_5ff9a2f5 thread scene::play("zm_zod_gateworm_idle_basin", var_5ff9a2f5);
        var_2c61a23c playloopsound("zmb_zod_ritual_pap_worm_firelvl1", 1);
        return;
    }
    var_5ff9a2f5 ghost();
    var_5ff9a2f5 stoploopsound(0.5);
}

// Namespace namespace_1f61c67f
// Params 1, eflags: 0x1 linked
// Checksum 0x22e07595, Offset: 0x75c0
// Size: 0xc4
function function_cabbbee5(str_flag) {
    var_e0258bdf = getentarray("worm_basin", "targetname");
    foreach (var_2c61a23c in var_e0258bdf) {
        if (var_2c61a23c.script_noteworthy === str_flag) {
            return var_2c61a23c;
        }
    }
}

// Namespace namespace_1f61c67f
// Params 2, eflags: 0x1 linked
// Checksum 0x9e927c41, Offset: 0x7690
// Size: 0x248
function function_2eacaa8(var_e7fbc48, str_flag) {
    if (var_e7fbc48) {
        str_side = "left";
    } else {
        str_side = "right";
    }
    var_8ac64fd8 = "quest_ritual_pap_wallrun_" + str_side;
    str_model = "quest_ritual_pap_frieze_" + str_side;
    var_634fac89 = getent(var_8ac64fd8, "targetname");
    var_634fac89 triggerenable(0);
    var_634fac89 thread function_748dfcde();
    var_8343c640 = getent(str_model, "targetname");
    var_8343c640 useanimtree(#generic);
    while (true) {
        flag::wait_till(str_flag);
        exploder::exploder("fx_exploder_ritual_" + str_flag + "_path");
        function_c5feeac3();
        function_2d6f72a1(var_e7fbc48, 1);
        if (var_e7fbc48) {
            level clientfield::set("wallrun_footprints", 1);
        } else {
            level clientfield::set("wallrun_footprints", 2);
        }
        flag::wait_till_clear(str_flag);
        function_cdd10ab3();
        exploder::stop_exploder("fx_exploder_ritual_" + str_flag + "_path");
        function_2d6f72a1(var_e7fbc48, 0);
    }
}

// Namespace namespace_1f61c67f
// Params 2, eflags: 0x1 linked
// Checksum 0x3f56c2af, Offset: 0x78e0
// Size: 0x21c
function function_2d6f72a1(var_e7fbc48, b_on) {
    if (var_e7fbc48) {
        str_side = "left";
    } else {
        str_side = "right";
    }
    var_634fac89 = getent("quest_ritual_pap_wallrun_" + str_side, "targetname");
    var_8343c640 = getent("quest_ritual_pap_frieze_" + str_side, "targetname");
    if (b_on) {
        var_4539ae4a = struct::get("quest_ritual_pap_wallimpacts_" + str_side, "targetname");
        level thread function_7107ea51(var_8343c640, var_4539ae4a);
        var_8343c640 animation::play("p7_fxanim_zm_zod_frieze_anim");
        var_8343c640 animation::first_frame("p7_fxanim_zm_zod_frieze_fall_anim");
        var_634fac89 triggerenable(1);
        var_634fac89 sethintstring("");
        exploder::exploder("fx_exploder_ritual_frieze_" + str_side + "_wallrun");
        level notify(#"hash_7107ea51");
        return;
    }
    exploder::stop_exploder("fx_exploder_ritual_frieze_" + str_side + "_wallrun");
    var_634fac89 triggerenable(0);
    var_8343c640 animation::play("p7_fxanim_zm_zod_frieze_fall_anim");
}

// Namespace namespace_1f61c67f
// Params 2, eflags: 0x1 linked
// Checksum 0x765f8d6f, Offset: 0x7b08
// Size: 0x17e
function function_7107ea51(var_b12a7acb, var_4539ae4a) {
    level notify(#"hash_7107ea51");
    level endon(#"hash_7107ea51");
    while (true) {
        var_b12a7acb util::waittill_any("impact_rumble", "rumble_stop");
        earthquake(0.5, 0.2, var_4539ae4a.origin, 512);
        foreach (player in level.activeplayers) {
            if (zombie_utility::is_player_valid(player) && distance2dsquared(player.origin, var_4539ae4a.origin) < 262144) {
                player namespace_8e578893::function_6edf48d5(6, 0.25);
            }
        }
    }
}

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x1 linked
// Checksum 0xacb1d675, Offset: 0x7c90
// Size: 0x44
function function_c5feeac3() {
    function_cbecf88b();
    level.var_4df5e1e7.var_3358c78c++;
    function_1ca877da();
    function_af60ae6e();
}

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x1 linked
// Checksum 0x6bc6d3b8, Offset: 0x7ce0
// Size: 0x44
function function_cdd10ab3() {
    function_cbecf88b();
    level.var_4df5e1e7.var_3358c78c--;
    function_1ca877da();
    function_af60ae6e();
}

// Namespace namespace_1f61c67f
// Params 1, eflags: 0x1 linked
// Checksum 0x26c453e, Offset: 0x7d30
// Size: 0x54
function function_d091666c(var_3358c78c) {
    function_cbecf88b();
    level.var_4df5e1e7.var_3358c78c = var_3358c78c;
    function_1ca877da();
    function_af60ae6e();
}

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x1 linked
// Checksum 0xe95f76f4, Offset: 0x7d90
// Size: 0x4c
function function_cbecf88b() {
    if (level.var_4df5e1e7.var_3358c78c > 0) {
        exploder::stop_exploder("fx_exploder_ritual_gatestone_" + level.var_4df5e1e7.var_3358c78c + "_glow");
    }
}

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x1 linked
// Checksum 0x68bdc6f3, Offset: 0x7de8
// Size: 0x6c
function function_1ca877da() {
    if (level.var_4df5e1e7.var_3358c78c > 0 && level.var_4df5e1e7.var_3358c78c < 5) {
        exploder::exploder("fx_exploder_ritual_gatestone_" + level.var_4df5e1e7.var_3358c78c + "_glow");
    }
}

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x1 linked
// Checksum 0xf7545882, Offset: 0x7e60
// Size: 0x54
function function_af60ae6e() {
    if (level.var_4df5e1e7.var_3358c78c > 0) {
        exploder::exploder("fx_exploder_ritual_chasm_awakened");
        return;
    }
    exploder::stop_exploder("fx_exploder_ritual_chasm_awakened");
}

// Namespace namespace_1f61c67f
// Params 1, eflags: 0x1 linked
// Checksum 0x9ed48652, Offset: 0x7ec0
// Size: 0x70
function function_748dfcde(var_634fac89) {
    while (true) {
        e_triggerer = self waittill(#"trigger");
        if (!(isdefined(e_triggerer.var_54343c90) && e_triggerer.var_54343c90)) {
            e_triggerer thread function_bf457d6e(self);
        }
    }
}

// Namespace namespace_1f61c67f
// Params 1, eflags: 0x1 linked
// Checksum 0x8fb76bdd, Offset: 0x7f38
// Size: 0xa0
function function_bf457d6e(t_trigger) {
    self endon(#"death");
    if (isdefined(self.beastmode) && self.beastmode) {
        return;
    }
    self.var_54343c90 = 1;
    self allowwallrun(1);
    while (self istouching(t_trigger)) {
        wait(0.05);
    }
    self allowwallrun(0);
    self.var_54343c90 = 0;
}

// Namespace namespace_1f61c67f
// Params 2, eflags: 0x1 linked
// Checksum 0x6af71da7, Offset: 0x7fe0
// Size: 0x1b8
function function_52d8dfb6(var_f7225255, str_flag) {
    if (var_f7225255) {
        str_side = "near";
    } else {
        str_side = "far";
    }
    var_94e9acae = getent("pap_chamber_middle_island_" + str_side, "targetname");
    var_94e9acae ghost();
    e_clip = getent("pap_chamber_middle_island_" + str_side + "_clip", "targetname");
    e_clip setinvisibletoall();
    while (true) {
        flag::wait_till(str_flag);
        function_c5feeac3();
        exploder::exploder("fx_exploder_ritual_" + str_flag + "_path");
        function_c3e5d4f(var_f7225255, 1);
        flag::wait_till_clear(str_flag);
        function_cdd10ab3();
        exploder::stop_exploder("fx_exploder_ritual_" + str_flag + "_path");
        function_c3e5d4f(var_f7225255, 0);
    }
}

// Namespace namespace_1f61c67f
// Params 2, eflags: 0x1 linked
// Checksum 0xb98271af, Offset: 0x81a0
// Size: 0x244
function function_c3e5d4f(var_f7225255, b_on) {
    if (var_f7225255) {
        str_side = "near";
        var_ea5390b2 = 1;
    } else {
        str_side = "far";
        var_ea5390b2 = 2;
    }
    var_94e9acae = getent("pap_chamber_middle_island_" + str_side, "targetname");
    var_94e9acae useanimtree(#generic);
    e_clip = getent("pap_chamber_middle_island_" + str_side + "_clip", "targetname");
    if (b_on) {
        var_4539ae4a = struct::get("quest_ritual_pap_bridgeimpacts_" + str_side, "targetname");
        level thread function_7107ea51(var_94e9acae, var_4539ae4a);
        var_94e9acae show();
        var_94e9acae animation::play("p7_fxanim_zm_zod_pap_bridge_0" + var_ea5390b2 + "_rise_anim");
        var_94e9acae animation::first_frame("p7_fxanim_zm_zod_pap_bridge_0" + var_ea5390b2 + "_fall_anim");
        e_clip setvisibletoall();
        level notify(#"hash_7107ea51");
        return;
    }
    e_clip setinvisibletoall();
    var_94e9acae animation::play("p7_fxanim_zm_zod_pap_bridge_0" + var_ea5390b2 + "_fall_anim");
    var_94e9acae ghost();
}

// Namespace namespace_1f61c67f
// Params 1, eflags: 0x1 linked
// Checksum 0x37fcf242, Offset: 0x83f0
// Size: 0x170
function function_cee28413(a_flags) {
    self notify(#"hash_cee28413");
    self endon(#"hash_cee28413");
    var_4e3ac1a1 = "pap_mid_jump_72";
    var_c2c49b4c = getnode(var_4e3ac1a1, "targetname");
    var_770e752e = getent("pap_chamber_middle_island_monster_clip", "targetname");
    while (true) {
        flag::wait_till_all(a_flags);
        var_770e752e moveto(var_770e752e.origin - (0, 0, 5000), 0.1);
        var_770e752e connectpaths();
        flag::wait_till_clear_any(a_flags);
        var_770e752e moveto(var_770e752e.origin + (0, 0, 5000), 0.1);
        var_770e752e disconnectpaths();
    }
}

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x1 linked
// Checksum 0xcc7a616d, Offset: 0x8568
// Size: 0x1f0
function function_d6a52a8a() {
    var_66ee586a = getent("pap_chasm_killtrigger", "targetname");
    level thread function_64cb1f9b("pap_chasm_side_far", 1);
    level thread function_64cb1f9b("pap_chasm_side_near", 0);
    while (true) {
        e_triggerer = var_66ee586a waittill(#"trigger");
        if (isplayer(e_triggerer)) {
            if (!(isdefined(e_triggerer.beastmode) && e_triggerer.beastmode)) {
                e_triggerer dodamage(1000000, e_triggerer.origin);
            }
            if (isdefined(e_triggerer.var_d9394bfb) && e_triggerer.var_d9394bfb) {
                var_38feb4f6 = struct::get_array("pap_chasm_return_point_far", "targetname");
            } else {
                var_38feb4f6 = struct::get_array("pap_chasm_return_point_near", "targetname");
            }
            var_8f51a1d6 = arraygetclosest(e_triggerer.origin, var_38feb4f6);
            e_triggerer setorigin(var_8f51a1d6.origin);
            e_triggerer setplayerangles(var_8f51a1d6.angles);
        }
    }
}

// Namespace namespace_1f61c67f
// Params 2, eflags: 0x1 linked
// Checksum 0x3b86c20, Offset: 0x8760
// Size: 0x94
function function_64cb1f9b(str_trigger_name, var_f8826470) {
    var_b354bc3b = getent(str_trigger_name, "targetname");
    while (true) {
        e_triggerer = var_b354bc3b waittill(#"trigger");
        if (isplayer(e_triggerer)) {
            e_triggerer.var_d9394bfb = var_f8826470;
        }
    }
}

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x8800
// Size: 0x4
function function_5761225() {
    
}

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x8810
// Size: 0x4
function function_45aff2d1() {
    
}

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x1 linked
// Checksum 0xc8a32922, Offset: 0x8820
// Size: 0x54
function player_death_watcher() {
    if (isdefined(level.var_18f5ce73)) {
        self thread [[ level.var_18f5ce73 ]]();
        return;
    }
    self notify(#"player_death_watcher");
    self endon(#"player_death_watcher");
    /#
        iprintlnbold("ritual_progress");
    #/
}

/#

    // Namespace namespace_1f61c67f
    // Params 0, eflags: 0x1 linked
    // Checksum 0x1f63159f, Offset: 0x8880
    // Size: 0x23c
    function quest_devgui() {
        level thread namespace_8e578893::function_72260d3a("ritual_progress", "ritual_progress", 1, &function_dc59b750);
        level thread namespace_8e578893::function_72260d3a("ritual_progress", "ritual_progress", 1, &namespace_81256d2f::function_3f95af32);
        level thread namespace_8e578893::function_72260d3a("ritual_progress", "ritual_progress", 1, &function_7dda8ea9);
        level thread namespace_8e578893::function_72260d3a("ritual_progress", "ritual_progress", 1, &function_6c6a5914);
        level thread namespace_8e578893::function_72260d3a("ritual_progress", "ritual_progress", 1, &function_c0a29676);
        level thread namespace_8e578893::function_72260d3a("ritual_progress", "ritual_progress", 1, &function_546835a);
        level thread namespace_8e578893::function_72260d3a("ritual_progress", "ritual_progress", 1, &function_832e2eaa);
        level thread namespace_8e578893::function_72260d3a("ritual_progress", "ritual_progress", 1, &function_11a2ca3b);
        level thread namespace_8e578893::function_72260d3a("ritual_progress", "ritual_progress", 1, &function_1dadcc76);
        level thread namespace_8e578893::function_72260d3a("ritual_progress", "ritual_progress", 1, &function_150df737);
    }

#/

// Namespace namespace_1f61c67f
// Params 1, eflags: 0x1 linked
// Checksum 0x1182ffd8, Offset: 0x8ac8
// Size: 0x5c
function function_150df737(n_val) {
    var_53729670 = level clientfield::get("rain_state");
    level clientfield::set("rain_state", !var_53729670);
}

// Namespace namespace_1f61c67f
// Params 1, eflags: 0x1 linked
// Checksum 0xe992965c, Offset: 0x8b30
// Size: 0x12a
function function_6c6a5914(n_val) {
    level clientfield::set("devgui_gateworm", 1);
    level thread namespace_81256d2f::function_2947f395();
    hidemiscmodels("robot_model");
    level flag::set("police_box_hide");
    var_dfda7cba = getentarray("robot_readout_model", "targetname");
    foreach (var_1d2e353b in var_dfda7cba) {
        var_1d2e353b hide();
    }
}

// Namespace namespace_1f61c67f
// Params 1, eflags: 0x1 linked
// Checksum 0xe938ec95, Offset: 0x8c68
// Size: 0x74
function function_546835a(n_val) {
    level endon(#"hash_832e2eaa");
    level thread exploder::stop_exploder("ritual_light_magician_fin");
    level thread function_79c39bdd("magician");
    wait(30);
    level thread function_96a27419("magician");
}

// Namespace namespace_1f61c67f
// Params 1, eflags: 0x1 linked
// Checksum 0xb0fd5bc2, Offset: 0x8ce8
// Size: 0x34
function function_832e2eaa(n_val) {
    level notify(#"hash_832e2eaa");
    level thread function_a9f5d007("magician");
}

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x1 linked
// Checksum 0x6e0f689d, Offset: 0x8d28
// Size: 0x26c
function function_c0a29676() {
    var_cbe37472 = array("ritual_boxer", "ritual_detective", "ritual_femme", "ritual_magician", "ritual_pap");
    foreach (var_5afbab23 in var_cbe37472) {
        namespace_f37770c8::function_682ff7f7(var_5afbab23);
    }
    level.var_522a1f61 = 1;
    var_f99f027c = array("relic_boxer", "relic_detective", "relic_femme", "relic_magician");
    for (i = 1; i < 5; i++) {
        str_flag = "pap_basin_" + i;
        exploder::exploder("fx_exploder_ritual_" + str_flag + "_path");
        var_a1b4f9cd = "relic_boxer";
        function_5eb042a7(str_flag, var_f99f027c[i - 1], 1);
        flag::set(str_flag);
    }
    function_2d6f72a1(1, 1);
    function_2d6f72a1(0, 1);
    function_c3e5d4f(1, 1);
    function_c3e5d4f(0, 1);
    function_d091666c(4);
    function_8ff18033();
}

/#

    // Namespace namespace_1f61c67f
    // Params 1, eflags: 0x1 linked
    // Checksum 0x28c38d41, Offset: 0x8fa0
    // Size: 0x44
    function function_11a2ca3b(val) {
        if (val) {
            level.overridezombiespawn = &function_861cf6b3;
            setdvar("ritual_progress", 0);
        }
    }

    // Namespace namespace_1f61c67f
    // Params 1, eflags: 0x1 linked
    // Checksum 0x96ccc3e5, Offset: 0x8ff0
    // Size: 0x3c
    function function_1dadcc76(val) {
        if (val) {
            level.overridezombiespawn = undefined;
            setdvar("ritual_progress", -1);
        }
    }

    // Namespace namespace_1f61c67f
    // Params 0, eflags: 0x1 linked
    // Checksum 0x920a8c27, Offset: 0x9038
    // Size: 0x6e
    function function_861cf6b3() {
        var_92d58fd4 = getentarray("ritual_progress", "ritual_progress");
        ai = var_92d58fd4[0] spawnfromspawner(0, 1);
        return ai;
    }

#/

// Namespace namespace_1f61c67f
// Params 1, eflags: 0x1 linked
// Checksum 0x8477a574, Offset: 0x90b0
// Size: 0x2c
function function_7dda8ea9(n_val) {
    level flag::set("keeper_sword_locker");
}

// Namespace namespace_1f61c67f
// Params 1, eflags: 0x1 linked
// Checksum 0x6193b9e4, Offset: 0x90e8
// Size: 0x24
function function_dc59b750(n_val) {
    function_dc210153(1);
}

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x1 linked
// Checksum 0x36880276, Offset: 0x9118
// Size: 0x18c
function function_83c8b6e8() {
    zm_pap_util::function_82c7ef16(&function_5630c228);
    zm_pap_util::function_b92a53ad(&function_ea272f07);
    mdl_pap = getent("vending_packapunch", "targetname");
    mdl_pap ghost();
    var_4197ca83 = zm_pap_util::function_f925b7b9();
    foreach (trigger in var_4197ca83) {
        trigger sethintstring("");
    }
    var_eadb7e53 = getent("pap_tentacle", "targetname");
    var_eadb7e53 useanimtree(#generic);
    var_eadb7e53 ghost();
}

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x1 linked
// Checksum 0x862df713, Offset: 0x92b0
// Size: 0x8a
function function_a6838c4f() {
    var_eadb7e53 = getent("pap_tentacle", "targetname");
    if (!isdefined(var_eadb7e53.var_6297f7c)) {
        var_eadb7e53.var_6297f7c = var_eadb7e53.angles;
    }
    var_eadb7e53 useanimtree(#generic);
    level notify(#"pack_a_punch_on");
}

// Namespace namespace_1f61c67f
// Params 4, eflags: 0x1 linked
// Checksum 0x2dc80e95, Offset: 0x9348
// Size: 0x42c
function function_5630c228(player, trigger, origin_offset, angles_offset) {
    level endon(#"pack_a_punch_off");
    trigger endon(#"pap_player_disconnected");
    var_c7c7077b = struct::get("pap_portal_center", "targetname");
    var_eadb7e53 = getent("pap_tentacle", "targetname");
    if (!isdefined(var_eadb7e53.var_6297f7c)) {
        var_eadb7e53.var_6297f7c = var_eadb7e53.angles;
    }
    var_eadb7e53.origin = var_c7c7077b.origin;
    var_eadb7e53.angles = var_eadb7e53.var_6297f7c;
    temp_ent = spawn("script_model", var_eadb7e53.origin);
    temp_ent.angles = var_eadb7e53.angles;
    temp_ent setmodel("tag_origin_animate");
    temp_ent useanimtree(#generic);
    playsoundatposition("zmb_zod_pap_activate", var_c7c7077b.origin);
    offsetdw = (3, 3, 3);
    var_33943bd9 = 0;
    trigger.worldgun = zm_utility::spawn_buildkit_weapon_model(player, trigger.current_weapon, undefined, self.origin, self.angles);
    worldgundw = undefined;
    if (trigger.current_weapon.isdualwield) {
        worldgundw = zm_utility::spawn_buildkit_weapon_model(player, trigger.current_weapon, undefined, self.origin + offsetdw, self.angles);
    }
    trigger.worldgun.worldgundw = worldgundw;
    trigger.worldgun linkto(temp_ent, "tag_origin", (0, 0, 0), angles_offset);
    offsetdw = (3, 3, 3);
    if (isdefined(trigger.worldgun.worldgundw)) {
        trigger.worldgun.worldgundw linkto(temp_ent, "tag_origin", offsetdw, angles_offset);
    }
    wait(0.5);
    temp_ent thread animation::play("o_zombie_zod_packapunch_tentacle_worldgun_taken");
    var_eadb7e53 show();
    var_eadb7e53 animation::play("o_zombie_zod_packapunch_tentacle_gun_take");
    var_eadb7e53 ghost();
    temp_ent delete();
    trigger.worldgun delete();
    if (isdefined(trigger.worldgun.worldgundw)) {
        trigger.worldgun.worldgundw delete();
    }
}

// Namespace namespace_1f61c67f
// Params 4, eflags: 0x1 linked
// Checksum 0x55e521be, Offset: 0x9780
// Size: 0x43c
function function_ea272f07(player, t_trigger, origin_offset, interact_offset) {
    level endon(#"pack_a_punch_off");
    t_trigger endon(#"pap_player_disconnected");
    var_c7c7077b = struct::get("pap_portal_center", "targetname");
    var_eadb7e53 = getent("pap_tentacle", "targetname");
    var_eadb7e53.origin = var_c7c7077b.origin;
    var_3acfce06 = spawn("script_model", var_eadb7e53.origin);
    var_3acfce06.angles = var_eadb7e53.angles;
    var_3acfce06 setmodel("tag_origin_animate");
    var_3acfce06 useanimtree(#generic);
    var_c9eddbc = 0;
    var_aa51a9ae = (3, 3, 3);
    t_trigger.worldgun = zm_utility::spawn_buildkit_weapon_model(player, t_trigger.upgrade_weapon, zm_weapons::function_11a37a(undefined), self.origin, self.angles);
    worldgundw = undefined;
    if (t_trigger.upgrade_weapon.isdualwield) {
        worldgundw = zm_utility::spawn_buildkit_weapon_model(player, t_trigger.upgrade_weapon, zm_weapons::function_11a37a(undefined), self.origin + var_aa51a9ae, self.angles);
    }
    t_trigger.worldgun.worldgundw = worldgundw;
    if (!isdefined(t_trigger.worldgun)) {
        return;
    }
    t_trigger.worldgun linkto(var_3acfce06, "tag_origin", (0, 0, 0), (0, 90, 0));
    if (isdefined(t_trigger.worldgun.worldgundw)) {
        t_trigger.worldgun.worldgundw linkto(var_3acfce06, "tag_origin", var_aa51a9ae, (0, 90, 0));
    }
    t_trigger thread function_4de2af97(var_eadb7e53, var_3acfce06);
    t_trigger util::waittill_any("pap_timeout", "pap_taken");
    t_trigger thread function_f46eb6f9();
    t_trigger thread function_b99f7d2b();
    var_3acfce06 delete();
    var_eadb7e53 animation::stop();
    var_eadb7e53 thread function_2934e5d0(t_trigger);
    if (isdefined(t_trigger.worldgun)) {
        if (isdefined(t_trigger.worldgun.worldgundw)) {
            t_trigger.worldgun.worldgundw delete();
        }
        t_trigger.worldgun delete();
    }
}

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x1 linked
// Checksum 0x7f436620, Offset: 0x9bc8
// Size: 0x3c
function function_f46eb6f9() {
    self endon(#"pap_timeout");
    self waittill(#"pap_taken");
    self playsound("zmb_zod_pap_take");
}

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x1 linked
// Checksum 0x44372806, Offset: 0x9c10
// Size: 0x3c
function function_b99f7d2b() {
    self endon(#"pap_taken");
    self waittill(#"pap_timeout");
    self playsound("zmb_zod_pap_lose");
}

// Namespace namespace_1f61c67f
// Params 2, eflags: 0x1 linked
// Checksum 0xb0aa7fb5, Offset: 0x9c58
// Size: 0x9c
function function_4de2af97(var_eadb7e53, var_3acfce06) {
    self endon(#"pap_timeout");
    self endon(#"pap_taken");
    var_3acfce06 thread animation::play("o_zombie_zod_packapunch_tentacle_worldgun_ejected");
    self thread function_e94f1c9c(var_eadb7e53);
    var_eadb7e53 animation::play("o_zombie_zod_packapunch_tentacle_extend");
    var_eadb7e53 thread animation::play("o_zombie_zod_packapunch_tentacle_extended_loop");
}

// Namespace namespace_1f61c67f
// Params 1, eflags: 0x1 linked
// Checksum 0x5f5789a9, Offset: 0x9d00
// Size: 0x44
function function_e94f1c9c(var_eadb7e53) {
    self endon(#"pap_timeout");
    self endon(#"pap_taken");
    wait(0.1);
    var_eadb7e53 show();
}

// Namespace namespace_1f61c67f
// Params 1, eflags: 0x1 linked
// Checksum 0x2080ec0e, Offset: 0x9d50
// Size: 0x4c
function function_2934e5d0(t_trigger) {
    t_trigger endon(#"pap_player_disconnected");
    self animation::play("o_zombie_zod_packapunch_tentacle_retract");
    self ghost();
}

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x0
// Checksum 0xf284bcf5, Offset: 0x9da8
// Size: 0x3c
function function_c7ea04e6() {
    self endon(#"death");
    self waittill(#"hash_bb7a9d17");
    self playsound("zmb_zod_pap_finish");
}

// Namespace namespace_1f61c67f
// Params 3, eflags: 0x0
// Checksum 0x4e6bbe2f, Offset: 0x9df0
// Size: 0x44
function function_81e2f06e(var_32d525d3, alias, var_c0cdb698) {
    self endon(var_c0cdb698);
    self waittill(var_32d525d3);
    self playsound(alias);
}

// Namespace namespace_1f61c67f
// Params 1, eflags: 0x1 linked
// Checksum 0x12793410, Offset: 0x9e40
// Size: 0xd6
function function_ae395e41(a_flags) {
    a_nodes = getnodearray("pap_bridge_node", "script_linkname");
    for (i = 0; i < a_nodes.size; i++) {
        setenablenode(a_nodes[i], 0);
    }
    flag::wait_till_all(a_flags);
    for (i = 0; i < a_nodes.size; i++) {
        setenablenode(a_nodes[i], 1);
    }
}

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x1 linked
// Checksum 0xf9f8190f, Offset: 0x9f20
// Size: 0x178
function function_b62ad2c() {
    var_b63ffd42 = level.var_c0091dc4["magician"];
    var_578145e1 = level.var_c0091dc4["boxer"];
    var_e6fe55fe = level.var_c0091dc4["detective"];
    var_bab3e119 = level.var_c0091dc4["femme"];
    var_18ffa2b3 = [];
    array::add(var_18ffa2b3, var_b63ffd42);
    array::add(var_18ffa2b3, var_578145e1);
    array::add(var_18ffa2b3, var_e6fe55fe);
    array::add(var_18ffa2b3, var_bab3e119);
    for (i = 0; i < var_18ffa2b3.size; i++) {
        var_4126c532 = var_18ffa2b3[i];
        if (var_4126c532.var_784ea913) {
            if (self istouching(var_4126c532.var_b8236eca)) {
                return var_4126c532;
            }
        }
    }
    return undefined;
}

// Namespace namespace_1f61c67f
// Params 0, eflags: 0x1 linked
// Checksum 0x8c14e5b4, Offset: 0xa0a0
// Size: 0x10
function function_15f1b929() {
    self.var_84f1bc44 = 0;
}

