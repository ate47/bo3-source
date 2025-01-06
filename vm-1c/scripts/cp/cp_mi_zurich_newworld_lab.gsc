#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_zurich_newworld;
#using scripts/cp/cp_mi_zurich_newworld_sound;
#using scripts/cp/cp_mi_zurich_newworld_train;
#using scripts/cp/cp_mi_zurich_newworld_util;
#using scripts/shared/audio_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace namespace_d2831417;

// Namespace namespace_d2831417
// Params 2, eflags: 0x0
// Checksum 0xeba860fa, Offset: 0x3c0
// Size: 0x4c
function function_8f94ea53(str_objective, var_74cd64bc) {
    level flag::wait_till("all_players_spawned");
    skipto::teleport("waking_up_igc");
}

// Namespace namespace_d2831417
// Params 2, eflags: 0x0
// Checksum 0xd4fac417, Offset: 0x418
// Size: 0x27c
function function_6383d314(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        namespace_c7062b04::function_c63fb1d();
        load::function_c32ba481();
        level thread newworld_util::function_30ec5bf7(1);
    }
    newworld_util::player_snow_fx();
    level scene::init("cin_new_17_01_wakingup_1st_reveal");
    level scene::init("p7_fxanim_cp_newworld_curtain_bundle");
    util::function_d8eaed3d(10);
    newworld_util::function_83a7d040();
    util::streamer_wait();
    function_c3e8639();
    level thread namespace_e38c3c58::function_9c65cf9a();
    level thread audio::unlockfrontendmusic("mus_new_world_chase_intro");
    level thread audio::unlockfrontendmusic("mus_new_world_brave_intro");
    if (isdefined(level.var_aacb4541)) {
        level thread [[ level.var_aacb4541 ]]();
    }
    scene::add_scene_func("cin_new_17_01_wakingup_1st_reveal", &function_4619fd7, "play");
    scene::add_scene_func("cin_new_17_01_wakingup_1st_reveal", &function_8247e7d3, "play");
    scene::add_scene_func("cin_new_17_01_wakingup_1st_reveal", &function_203a65ec, "skip_started");
    level thread scene::play("cin_new_17_01_wakingup_1st_reveal");
    level flag::clear("infinite_white_transition");
    level waittill(#"hash_720ce609");
    util::clear_streamer_hint();
    skipto::function_be8adfb8(str_objective);
}

// Namespace namespace_d2831417
// Params 1, eflags: 0x0
// Checksum 0x95f71037, Offset: 0x6a0
// Size: 0x82
function function_4619fd7(a_ents) {
    a_ents["player 1"] waittill(#"hash_bb969e7d");
    level clientfield::set("sndIGCsnapshot", 4);
    if (!scene::function_b1f75ee9()) {
        util::screen_fade_out(0.5, "white");
    }
    level notify(#"hash_720ce609");
}

// Namespace namespace_d2831417
// Params 1, eflags: 0x0
// Checksum 0xe3dacaea, Offset: 0x730
// Size: 0x44
function function_8247e7d3(a_ents) {
    a_ents["krueger"] waittill(#"hash_51e02617");
    level thread scene::play("p7_fxanim_cp_newworld_curtain_bundle");
}

// Namespace namespace_d2831417
// Params 1, eflags: 0x0
// Checksum 0xf38be140, Offset: 0x780
// Size: 0x2c
function function_203a65ec(a_ents) {
    util::screen_fade_out(0, "black");
}

// Namespace namespace_d2831417
// Params 0, eflags: 0x0
// Checksum 0x4b60627d, Offset: 0x7b8
// Size: 0x9c
function function_c3e8639() {
    level.var_fc1953ce dialog::say("tayr_there_was_no_way_to_0", 0.5, 1);
    level.var_fc1953ce dialog::say("tayr_your_dni_may_show_yo_0", 0.5, 1);
    level.var_fc1953ce dialog::say("tayr_sometimes_you_have_0", 1, 1);
    wait 0.5;
}

// Namespace namespace_d2831417
// Params 4, eflags: 0x0
// Checksum 0x5709521d, Offset: 0x860
// Size: 0x24
function function_3ff80cea(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    
}

