#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_hazard;
#using scripts/cp/_load;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_infection_util;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/util_shared;

#namespace underwater;

// Namespace underwater
// Params 0, eflags: 0x0
// Checksum 0x81bc9fb1, Offset: 0x330
// Size: 0x12
function main() {
    init_clientfields();
}

// Namespace underwater
// Params 0, eflags: 0x0
// Checksum 0x2ebf832, Offset: 0x350
// Size: 0x52
function init_clientfields() {
    clientfield::register("world", "infection_underwater_debris", 1, 1, "int");
    clientfield::register("toplayer", "water_motes", 1, 1, "int");
}

// Namespace underwater
// Params 2, eflags: 0x0
// Checksum 0x9e4650e9, Offset: 0x3b0
// Size: 0x18a
function function_9157ab7a(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        level clientfield::set("cathedral_water_state", 1);
        level scene::init("cin_inf_12_01_underwater_1st_fall_underwater02");
        load::function_a2995f22();
    }
    level notify(#"hash_7b06f432");
    foreach (player in level.activeplayers) {
        player thread hazard::function_e9b126ef(20, 0.9);
    }
    if (isdefined(level.var_abdc59db)) {
        level thread [[ level.var_abdc59db ]]();
    }
    level thread function_3598ea7();
    foreach (player in level.players) {
        player enableinvulnerability();
    }
    level thread scene::play("cin_inf_12_01_underwater_1st_fall_underwater02");
    playsoundatposition("evt_underwater_outro", (0, 0, 0));
}

// Namespace underwater
// Params 0, eflags: 0x0
// Checksum 0x33dcc703, Offset: 0x548
// Size: 0x14a
function function_3598ea7() {
    level thread clientfield::set("infection_underwater_debris", 1);
    array::thread_all(level.players, &clientfield::set_to_player, "water_motes", 1);
    level util::waittill_either("underwater_scene_fade", "underwater_scene_done");
    level clientfield::set("sndIGCsnapshot", 4);
    array::thread_all(level.activeplayers, &util::function_16c71b8, 1);
    if (scene::function_b1f75ee9()) {
        level thread util::screen_fade_out(0, "black", "end_level_fade");
    } else {
        level thread util::screen_fade_out(2, "black", "end_level_fade");
    }
    array::thread_all(level.players, &clientfield::set_to_player, "water_motes", 0);
    level thread skipto::function_be8adfb8("underwater");
}

// Namespace underwater
// Params 4, eflags: 0x0
// Checksum 0xe9a86b0e, Offset: 0x6a0
// Size: 0xb3
function function_1c0537db(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    level thread clientfield::set("infection_underwater_debris", 0);
    level clientfield::set("cathedral_water_state", 0);
    foreach (player in level.activeplayers) {
        player thread hazard::function_60455f28("o2");
    }
}

