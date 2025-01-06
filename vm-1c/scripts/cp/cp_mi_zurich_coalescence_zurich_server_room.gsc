#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_zurich_coalescence_sound;
#using scripts/cp/cp_mi_zurich_coalescence_util;
#using scripts/cp/cp_mi_zurich_coalescence_zurich_hq;
#using scripts/cp/cp_mi_zurich_coalescence_zurich_plaza_battle;
#using scripts/cp/cp_mi_zurich_coalescence_zurich_sacrifice;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/player_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace namespace_e0fbc9fc;

// Namespace namespace_e0fbc9fc
// Params 2, eflags: 0x0
// Checksum 0xbc1b28fc, Offset: 0x660
// Size: 0x38c
function function_9c1fc2fd(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        level thread zurich_util::function_11b424e5(1);
        level function_f62d8d36();
        level flag::set("sacrifice_kane_activation_ready");
        level scene::skipto_end("cin_zur_06_sacrifice_3rd_sh150");
        level thread function_ef7b97bd();
        objectives::set("cp_level_zurich_apprehend_hack_obj");
        load::function_a2995f22();
    }
    e_who = level function_4d2c0fc8();
    array::thread_all(level.players, &function_7a462130, e_who);
    array::wait_till(level.players, "pistol_ready");
    array::thread_all(level.players, &zurich_util::set_world_fog, 1);
    if (isdefined(level.var_f3caeac8)) {
        level thread [[ level.var_f3caeac8 ]]();
    }
    level thread namespace_67110270::function_40b3f4d();
    level thread util::function_d8eaed3d(3);
    foreach (player in level.players) {
        if (player ishost()) {
            var_91f5b1a9 = player;
            break;
        }
    }
    if (!isdefined(var_91f5b1a9)) {
        var_91f5b1a9 = e_who;
    }
    scene::add_scene_func("cin_zur_09_01_standoff_1st_hostage", &function_46f876ee, "play");
    scene::add_scene_func("cin_zur_09_01_standoff_1st_hostage", &function_adc1f7a2, "done");
    level thread scene::play("cin_zur_09_01_standoff_1st_hostage", e_who);
    objectives::hide("cp_level_zurich_apprehend_hack_obj");
    objectives::set("cp_level_zurich_apprehend_awaiting_obj");
    level waittill(#"hash_265469bd");
    level thread util::screen_fade_out(0.1, "white");
    level waittill(#"hash_a4928ac9");
    level thread zurich_util::function_11b424e5(0);
    skipto::function_be8adfb8(str_objective);
}

// Namespace namespace_e0fbc9fc
// Params 1, eflags: 0x0
// Checksum 0x2939225d, Offset: 0x9f8
// Size: 0x22c
function function_7a462130(e_who) {
    e_player = self;
    var_b6abbe7a = getweapon("pistol_standard_zur");
    e_player enableweapons();
    if (e_player == e_who) {
        level.e_triggerer = e_player;
        level.e_triggerer hideviewmodel();
    }
    if (e_player hasweapon(var_b6abbe7a, 1)) {
        e_player.var_9299077 = 1;
    } else {
        e_player giveweapon(var_b6abbe7a);
    }
    w_current = e_player getcurrentweapon();
    a_weapon_list = e_player getweaponslist();
    foreach (weapon in a_weapon_list) {
        if (weapon.rootweapon.name == var_b6abbe7a.rootweapon.name && w_current.rootweapon.name != var_b6abbe7a.rootweapon.name) {
            e_player switchtoweapon(weapon);
            e_player waittill(#"weapon_change_complete");
            break;
        }
    }
    waittillframeend();
    e_player notify(#"pistol_ready");
}

// Namespace namespace_e0fbc9fc
// Params 0, eflags: 0x0
// Checksum 0xaf53ee7e, Offset: 0xc30
// Size: 0x98
function function_4d2c0fc8() {
    e_who = getent("server_room_door_usetrig", "targetname") zurich_util::function_d1996775();
    e_who playsound("evt_standoff_door");
    getent("sacrifice_server_door", "targetname") movez(-128, 2);
    return e_who;
}

// Namespace namespace_e0fbc9fc
// Params 1, eflags: 0x0
// Checksum 0x22a6c481, Offset: 0xcd0
// Size: 0x1ea
function function_46f876ee(a_ents) {
    level._effect["muzzle_flash"] = "weapon/fx_muz_pistol_igc";
    var_6262a4fe = a_ents["hendricks"];
    level waittill(#"hash_814598ff");
    var_6262a4fe cybercom::function_f8669cbf(1);
    level waittill(#"fire");
    foreach (e_player in level.activeplayers) {
        playfxontag(level._effect["muzzle_flash"], e_player, "tag_flash");
        e_player playrumbleonentity("pistol_fire");
    }
    wait 0.1;
    level waittill(#"fire");
    foreach (e_player in level.players) {
        playfxontag(level._effect["muzzle_flash"], e_player, "tag_flash");
    }
}

// Namespace namespace_e0fbc9fc
// Params 1, eflags: 0x0
// Checksum 0xe502ae3b, Offset: 0xec8
// Size: 0xe4
function function_adc1f7a2(a_ents) {
    foreach (e_player in level.players) {
        if (!(isdefined(e_player.var_9299077) && e_player.var_9299077)) {
            e_player takeweapon(getweapon("pistol_standard_zur"));
        }
    }
    level.e_triggerer showviewmodel();
}

// Namespace namespace_e0fbc9fc
// Params 4, eflags: 0x0
// Checksum 0x693e434b, Offset: 0xfb8
// Size: 0x232
function function_1a4dfaaa(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    spawner::add_global_spawn_function("axis", &zurich_util::function_b1d28dc8);
    spawner::add_global_spawn_function("axis", &zurich_util::function_90de3a76);
    level.var_6b5304af = getnodearray("ai_taylor_cover", "script_noteworthy");
    foreach (nd_cover in level.var_6b5304af) {
        setenablenode(nd_cover, 0);
    }
    objectives::set("cp_level_zurich_apprehend_awaiting_obj");
    objectives::hide("cp_level_zurich_apprehend_awaiting_obj");
    objectives::set("cp_level_zurich_unavailable_obj");
    zurich_util::function_4d032f25(0);
    namespace_b73b0f52::function_8cb99e45();
    namespace_68404a06::function_2d235e66();
    namespace_68404a06::function_1dc45e88();
    namespace_68404a06::function_3f3aadf9();
    level thread zurich_util::function_4a00a473("server_room");
    level.activeplayers function_69ee2ece();
    array::thread_all(level.players, &zurich_util::set_world_fog, 0);
    level notify(#"hq_ambient_cleanup");
}

// Namespace namespace_e0fbc9fc
// Params 0, eflags: 0x0
// Checksum 0x8bf7b791, Offset: 0x11f8
// Size: 0x94
function function_f62d8d36() {
    var_2fd26037 = spawner::simple_spawn_single("hendricks_server_igc_spawner");
    var_2fd26037 ai::gun_switchto(var_2fd26037.sidearm, "right");
    var_2fd26037 setteam("neutral");
    level scene::init("cin_zur_09_01_standoff_1st_hostage", var_2fd26037);
}

// Namespace namespace_e0fbc9fc
// Params 0, eflags: 0x0
// Checksum 0x81dae11a, Offset: 0x1298
// Size: 0x148
function function_69ee2ece() {
    foreach (e_player in self) {
        a_w_list = e_player getweaponslist();
        foreach (var_cdee635d in a_w_list) {
            if (isdefined(var_cdee635d.isheroweapon) && var_cdee635d.isheroweapon) {
                e_player takeweapon(var_cdee635d);
            }
        }
    }
}

// Namespace namespace_e0fbc9fc
// Params 0, eflags: 0x0
// Checksum 0x9b42c5f8, Offset: 0x13e8
// Size: 0x3aa
function function_ef7b97bd() {
    level scene::add_scene_func("cin_gen_ambient_raven_idle_eating_raven", &zurich_util::function_e547724d, "init");
    level scene::add_scene_func("cin_gen_ambient_raven_idle", &zurich_util::function_e547724d, "init");
    level scene::add_scene_func("cin_gen_traversal_raven_fly_away", &zurich_util::function_86b1cd8a, "init");
    a_scenes = struct::get_array("server_hallway_ravens");
    array::thread_all(a_scenes, &scene::init);
    zurich_util::function_1b3dfa61("server_hallway_hallucination_struct_trig", undefined, 96, 512);
    array::thread_all(level.players, &clientfield::set_to_player, "raven_hallucinations", 1);
    foreach (player in level.players) {
        visionset_mgr::activate("visionset", "cp_zurich_hallucination", player);
    }
    playsoundatposition("evt_server_ravens_f", (0, 0, 0));
    level notify(#"hash_755edaa4");
    foreach (s_scene in a_scenes) {
        s_scene util::delay(randomfloat(1), undefined, &scene::play);
    }
    wait 1;
    array::thread_all(level.players, &clientfield::set_to_player, "raven_hallucinations", 0);
    wait 0.5;
    array::thread_all(a_scenes, &scene::stop);
    wait 2;
    foreach (player in level.players) {
        visionset_mgr::deactivate("visionset", "cp_zurich_hallucination", player);
    }
}

