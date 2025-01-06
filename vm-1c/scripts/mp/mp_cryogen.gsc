#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/mp_cryogen_fx;
#using scripts/mp/mp_cryogen_sound;
#using scripts/shared/array_shared;
#using scripts/shared/compass;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace mp_cryogen;

// Namespace mp_cryogen
// Params 0, eflags: 0x0
// Checksum 0x898056bf, Offset: 0x218
// Size: 0x11c
function main() {
    precache();
    mp_cryogen_fx::main();
    mp_cryogen_sound::main();
    load::main();
    compass::setupminimap("compass_map_mp_cryogen");
    setdvar("compassmaxrange", "2100");
    level.cleandepositpoints = array((-115.486, -454.185, 0.125), (956.442, -1586.68, 0.125), (1214.72, -76.1687, 40.125), (167.401, -1543.29, -127.875));
    level thread scene_sequence("p7_fxanim_mp_cry_vista_tower_01_bundle");
}

// Namespace mp_cryogen
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x340
// Size: 0x4
function precache() {
    
}

// Namespace mp_cryogen
// Params 1, eflags: 0x0
// Checksum 0x75ec52bd, Offset: 0x350
// Size: 0x128
function scene_sequence(str_scene) {
    var_aae314ac = 25;
    var_9a15ce42 = 35;
    var_3aeeca62 = 0.5;
    var_df291458 = 3;
    while (true) {
        wait randomfloatrange(var_aae314ac, var_9a15ce42);
        level thread function_cfe901b9(str_scene, "ring_01_towers", var_3aeeca62, var_df291458);
        wait randomfloatrange(var_aae314ac, var_9a15ce42);
        level thread function_cfe901b9(str_scene, "ring_02_towers", var_3aeeca62, var_df291458);
        wait randomfloatrange(var_aae314ac, var_9a15ce42);
        level thread function_cfe901b9(str_scene, "ring_03_towers", var_3aeeca62, var_df291458);
    }
}

// Namespace mp_cryogen
// Params 4, eflags: 0x0
// Checksum 0xcbe1eb95, Offset: 0x480
// Size: 0x74
function function_cfe901b9(str_scene, str_ring, min_time, max_time) {
    level thread init_scene(str_scene, str_ring, min_time, max_time);
    wait 10;
    level thread run_scene(str_scene, str_ring, min_time, max_time);
}

// Namespace mp_cryogen
// Params 4, eflags: 0x0
// Checksum 0x84ff01a7, Offset: 0x500
// Size: 0x252
function run_scene(str_scene, str_targetname, min_time, max_time) {
    b_found = 0;
    str_mode = tolower(getdvarstring("scene_menu_mode", "default"));
    a_scenes = function_76d36418(struct::get_array(str_scene, "scriptbundlename"), 0, str_targetname);
    foreach (s_instance in a_scenes) {
        if (isdefined(s_instance)) {
            if (!isinarray(a_scenes, s_instance)) {
                b_found = 1;
                s_instance thread function_f3529f1a(undefined, str_mode, min_time, max_time);
            }
        }
    }
    if (isdefined(level.active_scenes[str_scene])) {
        a_scenes = function_76d36418(level.active_scenes[str_scene], 0, str_targetname);
        if (isdefined(a_scenes)) {
            foreach (s_instance in a_scenes) {
                b_found = 1;
                s_instance thread function_f3529f1a(str_scene, str_mode, min_time, max_time);
            }
        }
    }
}

// Namespace mp_cryogen
// Params 4, eflags: 0x0
// Checksum 0xbb5438e2, Offset: 0x760
// Size: 0x17c
function init_scene(str_scene, str_targetname, min_time, max_time) {
    str_mode = tolower(getdvarstring("scene_menu_mode", "default"));
    b_found = 0;
    a_scenes = function_76d36418(struct::get_array(str_scene, "scriptbundlename"), 0, str_targetname);
    foreach (s_instance in a_scenes) {
        if (isdefined(s_instance)) {
            b_found = 1;
            s_instance thread function_cf748f4e(undefined, min_time, max_time);
        }
    }
    if (!b_found) {
        level.scene_test_struct thread function_cf748f4e(str_scene, min_time, max_time);
    }
}

// Namespace mp_cryogen
// Params 3, eflags: 0x0
// Checksum 0xb36ad2aa, Offset: 0x8e8
// Size: 0x4a
function function_76d36418(&array, b_keep_keys, str_targetname) {
    return array::filter(array, b_keep_keys, &function_e35699e3, str_targetname);
}

// Namespace mp_cryogen
// Params 2, eflags: 0x0
// Checksum 0xcdffbd67, Offset: 0x940
// Size: 0x28
function function_e35699e3(val, arg) {
    return val.targetname === arg;
}

// Namespace mp_cryogen
// Params 4, eflags: 0x0
// Checksum 0xb279a18b, Offset: 0x970
// Size: 0x84
function function_f3529f1a(str_scene, str_mode, min_time, max_time) {
    if (min_time >= 0 && max_time > 0) {
        wait randomfloatrange(min_time, max_time);
    }
    self thread scene::play(str_scene, undefined, undefined, 1, undefined, str_mode);
}

// Namespace mp_cryogen
// Params 3, eflags: 0x0
// Checksum 0xe3861f4c, Offset: 0xa00
// Size: 0x74
function function_cf748f4e(str_scene, min_time, max_time) {
    if (min_time >= 0 && max_time > 0) {
        wait randomfloatrange(min_time, max_time);
    }
    self thread scene::init(str_scene, undefined, undefined, 1);
}

