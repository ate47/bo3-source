#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/cp/_safehouse;
#using scripts/cp/_util;
#using scripts/cp/cp_sh_mobile_fx;
#using scripts/cp/cp_sh_mobile_sound;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace cp_sh_mobile;

// Namespace cp_sh_mobile
// Params 0, eflags: 0x0
// Checksum 0xf3d1d24f, Offset: 0x3d0
// Size: 0xca
function main() {
    cp_sh_mobile_fx::main();
    cp_sh_mobile_sound::main();
    load::main();
    level thread function_ad7adee8();
    level thread function_56051a78();
    level scene::add_scene_func("p_player_enter_readyroom_mobile", &function_1b1968a9, "init");
    level.var_8ea79b65 = &function_6c5a247e;
    level.var_58373e3b = &function_3a7a79ca;
    level.var_f3db725a = &function_9e35a10d;
}

// Namespace cp_sh_mobile
// Params 0, eflags: 0x0
// Checksum 0xe2037f6, Offset: 0x4a8
// Size: 0x12a
function function_ad7adee8() {
    level thread function_6d9e2e34();
    level flag::wait_till("all_players_connected");
    safehouse::function_a85e8026(2);
    level thread function_301c79b5(1);
    switch (level.next_map) {
    case "cp_mi_eth_prologue":
        level util::set_lighting_state(0);
        break;
    case "cp_mi_cairo_ramses":
    case "cp_mi_cairo_ramses2":
    case "cp_mi_cairo_ramses3":
        level util::set_lighting_state(1);
        safehouse::function_a85e8026(1);
        function_301c79b5(2);
        break;
    case "cp_mi_zurich_coalescence":
        level util::set_lighting_state(1);
        safehouse::function_a85e8026(3);
        function_301c79b5(3);
        break;
    }
    level.var_ac964c36 = 1;
    level thread rumbles();
}

// Namespace cp_sh_mobile
// Params 1, eflags: 0x0
// Checksum 0x7fe42f1a, Offset: 0x5e0
// Size: 0x32
function function_1b1968a9(a_ents) {
    mdl_door = a_ents["safe_room_door"];
    mdl_door notsolid();
}

// Namespace cp_sh_mobile
// Params 0, eflags: 0x0
// Checksum 0x3b33e73d, Offset: 0x620
// Size: 0x12d
function rumbles() {
    v_source = (56, 0, 439);
    while (true) {
        if (randomint(100) < 20) {
            wait randomfloatrange(0.5, 3);
        } else {
            wait randomfloatrange(5, 10);
        }
        n_rand = randomint(100);
        if (isdefined(level.var_ac964c36) && level.var_ac964c36) {
            if (n_rand < 10) {
                earthquake(0.2, 0.75, v_source, 2000);
            } else if (n_rand < 40) {
                earthquake(0.1, 0.75, v_source, 2000);
            } else {
                earthquake(0.1, 0.5, v_source, 2000);
            }
            playsoundatposition("evt_fuselage_shake", v_source);
        }
    }
}

// Namespace cp_sh_mobile
// Params 0, eflags: 0x0
// Checksum 0x5cb23389, Offset: 0x758
// Size: 0xff
function function_6d9e2e34() {
    level.var_ea4a62a = util::spawn_model("tag_origin");
    callback::on_spawned(&function_eb7433ac);
    while (true) {
        var_418e8f74 = randomfloatrange(0.25, 1);
        n_time = randomfloatrange(3, 6);
        level.var_ea4a62a rotateroll(var_418e8f74, n_time, n_time / 2, n_time / 2);
        level.var_ea4a62a waittill(#"rotatedone");
        level.var_ea4a62a rotateroll(var_418e8f74 * -1, n_time, n_time / 2, n_time / 2);
        level.var_ea4a62a waittill(#"rotatedone");
    }
}

// Namespace cp_sh_mobile
// Params 0, eflags: 0x0
// Checksum 0xff57b704, Offset: 0x860
// Size: 0x6d
function function_eb7433ac() {
    self endon(#"death");
    while (true) {
        self playersetgroundreferenceent(level.var_ea4a62a);
        self flag::wait_till("in_training_sim");
        self playersetgroundreferenceent(undefined);
        self flag::wait_till_clear("in_training_sim");
    }
}

// Namespace cp_sh_mobile
// Params 0, eflags: 0x0
// Checksum 0xd5d6c42c, Offset: 0x8d8
// Size: 0x9f
function function_9ca26ba0() {
    while (true) {
        var_418e8f74 = randomfloatrange(0.25, 1);
        n_time = randomfloatrange(3, 6);
        self rotateroll(var_418e8f74, n_time, n_time / 2, n_time / 2);
        self waittill(#"rotatedone");
        self rotateroll(var_418e8f74 * -1, n_time, n_time / 2, n_time / 2);
        self waittill(#"rotatedone");
    }
}

// Namespace cp_sh_mobile
// Params 0, eflags: 0x0
// Checksum 0xd517843b, Offset: 0x980
// Size: 0x49
function function_6c5a247e() {
    switch (level.next_map) {
    case "cp_mi_eth_prologue":
        util::set_lighting_state(1);
        break;
    default:
        util::set_lighting_state(0);
        break;
    }
}

// Namespace cp_sh_mobile
// Params 0, eflags: 0x0
// Checksum 0xfdedd1f5, Offset: 0x9d8
// Size: 0x12
function function_3a7a79ca() {
    util::set_lighting_state();
}

// Namespace cp_sh_mobile
// Params 0, eflags: 0x0
// Checksum 0xc2b9b7df, Offset: 0x9f8
// Size: 0x12
function function_9e35a10d() {
    util::set_lighting_state(1);
}

// Namespace cp_sh_mobile
// Params 1, eflags: 0x0
// Checksum 0xf9f88b5d, Offset: 0xa18
// Size: 0x155
function function_301c79b5(n_num) {
    wait 1;
    var_1d257bd1 = getent("fxanim_skybox_01", "targetname");
    var_4327f63a = getent("fxanim_skybox_02", "targetname");
    var_692a70a3 = getent("fxanim_skybox_03", "targetname");
    switch (n_num) {
    case 1:
        var_1d257bd1 show();
        var_4327f63a hide();
        var_692a70a3 hide();
        break;
    case 2:
        var_1d257bd1 hide();
        var_4327f63a show();
        var_692a70a3 hide();
        break;
    case 3:
        var_1d257bd1 hide();
        var_4327f63a hide();
        var_692a70a3 show();
        break;
    }
}

// Namespace cp_sh_mobile
// Params 0, eflags: 0x0
// Checksum 0x435794c2, Offset: 0xb78
// Size: 0x229
function function_56051a78() {
    a_str_scenes = [];
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_bloodmopping_clean";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_balcony_surveying_guy01";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_balcony_surveying_guy02";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_scaffold_inspecting";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_saf_mob_armory_vign_repair_3dprinter";
    e_spawner = getent("worker_spawner", "targetname");
    a_str_scenes = array::randomize(a_str_scenes);
    var_c25c66df = randomintrange(2, 3);
    /#
    #/
    for (var_8640fa79 = 0; var_8640fa79 < var_c25c66df; var_8640fa79++) {
        str_scene = a_str_scenes[var_8640fa79];
        level thread scene::play(str_scene, e_spawner);
    }
}

