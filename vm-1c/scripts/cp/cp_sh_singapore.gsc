#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/cp/_safehouse;
#using scripts/cp/_util;
#using scripts/cp/cp_sh_singapore_fx;
#using scripts/cp/cp_sh_singapore_sound;
#using scripts/shared/array_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace cp_sh_singapore;

// Namespace cp_sh_singapore
// Params 0, eflags: 0x0
// Checksum 0x440b5d99, Offset: 0x350
// Size: 0x64
function main() {
    cp_sh_singapore_fx::main();
    cp_sh_singapore_sound::main();
    load::main();
    level thread function_ad7adee8();
    level thread function_56051a78();
}

// Namespace cp_sh_singapore
// Params 0, eflags: 0x0
// Checksum 0x43e00092, Offset: 0x3c0
// Size: 0xd6
function function_ad7adee8() {
    level flag::wait_till("all_players_connected");
    switch (level.next_map) {
    case "cp_mi_sing_blackstation":
        level util::set_lighting_state(0);
        break;
    case "cp_mi_sing_biodomes":
    case "cp_mi_sing_biodomes2":
        level util::set_lighting_state(1);
        break;
    case "cp_mi_sing_sgen":
        level util::set_lighting_state(0);
        break;
    case "cp_mi_sing_vengeance":
        level util::set_lighting_state(2);
        break;
    }
}

// Namespace cp_sh_singapore
// Params 0, eflags: 0x0
// Checksum 0xf5129561, Offset: 0x4a0
// Size: 0x346
function function_56051a78() {
    function_82dd4dd2("cin_ram_02_03_station_vign_readingipad_guy01");
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
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_readingipad_guy01";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_saf_bla_armory_vign_repair_3dprinter";
    e_spawner = getent("worker_spawner", "targetname");
    a_str_scenes = array::randomize(a_str_scenes);
    var_c25c66df = randomintrange(3, 4);
    /#
    #/
    for (var_8640fa79 = 0; var_8640fa79 < var_c25c66df; var_8640fa79++) {
        str_scene = a_str_scenes[var_8640fa79];
        level thread scene::play(str_scene, e_spawner);
    }
}

// Namespace cp_sh_singapore
// Params 1, eflags: 0x0
// Checksum 0xe894ce9d, Offset: 0x7f0
// Size: 0xb0
function function_82dd4dd2(str_scene) {
    foreach (s_scenedef in struct::get_script_bundles("scene")) {
        if (s_scenedef.name === str_scene) {
            s_scenedef.aligntarget = undefined;
        }
    }
}

