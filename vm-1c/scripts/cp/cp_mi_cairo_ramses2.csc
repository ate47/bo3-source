#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_ramses2_fx;
#using scripts/cp/cp_mi_cairo_ramses2_patch_c;
#using scripts/cp/cp_mi_cairo_ramses2_sound;
#using scripts/cp/cp_mi_cairo_ramses_arena_defend;
#using scripts/cp/cp_mi_cairo_ramses_utility;
#using scripts/shared/array_shared;
#using scripts/shared/beam_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicles/_quadtank;

#namespace cp_mi_cairo_ramses2;

// Namespace cp_mi_cairo_ramses2
// Params 0, eflags: 0x0
// Checksum 0x151a3e8f, Offset: 0xaa8
// Size: 0x2e4
function main() {
    util::function_57b966c8(&force_streamer, 5);
    init_clientfields();
    scene::add_scene_func("p7_fxanim_cp_ramses_lotus_towers_hunters_01_bundle", &function_33783216, "play");
    scene::add_scene_func("p7_fxanim_cp_ramses_lotus_towers_hunters_02_bundle", &function_d75b7ad, "play");
    scene::add_scene_func("p7_fxanim_cp_ramses_lotus_towers_hunters_02_bundle", &function_519a7da5, "play");
    scene::add_scene_func("p7_fxanim_cp_ramses_lotus_towers_hunters_03_bundle", &function_e7733d44, "play");
    scene::add_scene_func("p7_fxanim_cp_ramses_lotus_towers_hunters_04_bundle", &function_c170c2db, "play");
    scene::add_scene_func("p7_fxanim_cp_ramses_lotus_towers_hunters_05_bundle", &function_9b6e4872, "play");
    scene::add_scene_func("p7_fxanim_cp_ramses_lotus_towers_hunters_06_bundle", &function_756bce09, "play");
    scene::add_scene_func("p7_fxanim_cp_ramses_lotus_towers_hunters_07_bundle", &function_4f6953a0, "play");
    scene::add_scene_func("p7_fxanim_cp_ramses_lotus_towers_hunters_08_bundle", &function_898e7fc7, "play");
    scene::add_scene_func("p7_fxanim_cp_ramses_qt_plaza_palace_wall_collapse_bundle", &function_66424409, "play");
    scene::add_scene_func("p7_fxanim_cp_ramses_lotus_towers_hunters_07_vtol_igc_bundle", &function_a8ab3d99, "play");
    cp_mi_cairo_ramses2_fx::main();
    cp_mi_cairo_ramses2_sound::main();
    load::main();
    level.var_10d89562 = findstaticmodelindexarray("destroyed_interior");
    level.var_c6e7f081 = findstaticmodelindexarray("mobile_wall_sidewalk_smash_after");
    cp_mi_cairo_ramses2_patch_c::function_7403e82b();
    util::waitforclient(0);
}

// Namespace cp_mi_cairo_ramses2
// Params 0, eflags: 0x0
// Checksum 0x526982b2, Offset: 0xd98
// Size: 0x31c
function init_clientfields() {
    clientfield::register("toplayer", "player_spike_plant_postfx", 1, 1, "counter", &player_spike_plant_postfx, 0, 0);
    clientfield::register("world", "alley_fog_banks", 1, 1, "int", &alley_fog_banks, 0, 0);
    clientfield::register("world", "arena_defend_fxanim_hunters", 1, 1, "int", &arena_defend_fxanim_hunters, 0, 0);
    clientfield::register("world", "alley_fxanim_hunters", 1, 1, "int", &alley_fxanim_hunters, 0, 0);
    clientfield::register("world", "alley_fxanim_curtains", 1, 1, "int", &alley_fxanim_curtains, 0, 0);
    clientfield::register("world", "vtol_igc_fxanim_hunter", 1, 1, "int", &function_ac82c57e, 0, 0);
    clientfield::register("world", "qt_plaza_fxanim_hunters", 1, 1, "int", &qt_plaza_fxanim_hunters, 0, 0);
    clientfield::register("world", "theater_fxanim_swap", 1, 1, "int", &theater_fxanim_swap, 0, 0);
    clientfield::register("world", "qt_plaza_outro_exposure", 1, 1, "int", &function_be694d80, 0, 0);
    clientfield::register("world", "arena_defend_mobile_wall_damage", 1, 1, "int", &function_e3a0ff9c, 0, 0);
    clientfield::register("world", "hide_statue_rubble", 1, 1, "int", &hide_statue_rubble, 0, 0);
}

// Namespace cp_mi_cairo_ramses2
// Params 1, eflags: 0x0
// Checksum 0xeccd4871, Offset: 0x10c0
// Size: 0xd6
function force_streamer(n_zone) {
    switch (n_zone) {
    case 1:
        loadsiegeanim("p7_fxanim_gp_drone_hunter_swarm_large_sanim");
        break;
    case 2:
        forcestreamxmodel("c_hro_khalil_egypt_fb");
        break;
    case 3:
        loadsiegeanim("p7_fxanim_gp_drone_hunter_swarm_large_sanim");
        break;
    case 4:
        loadsiegeanim("p7_fxanim_gp_drone_hunter_swarm_large_sanim");
    case 5:
        loadsiegeanim("p7_fxanim_gp_drone_hunter_swarm_large_sanim");
        break;
    }
}

// Namespace cp_mi_cairo_ramses2
// Params 1, eflags: 0x0
// Checksum 0x16a60ea8, Offset: 0x11a0
// Size: 0xdc
function function_33783216(a_ents) {
    a_ents["hunter"] waittillmatch(#"_anim_notify_", "hunter01_hit_by_dead");
    level beam::launch(a_ents["hunter"], "tag_fx_jnt", a_ents["hunter"], "drone_01_link_jnt", "dead_turret_beam");
    a_ents["hunter"] waittillmatch(#"_anim_notify_", "hunter01_explodes");
    level beam::kill(a_ents["hunter"], "tag_fx_jnt", a_ents["hunter"], "drone_01_link_jnt", "dead_turret_beam");
}

// Namespace cp_mi_cairo_ramses2
// Params 1, eflags: 0x0
// Checksum 0x678088d9, Offset: 0x1288
// Size: 0xdc
function function_d75b7ad(a_ents) {
    a_ents["hunter"] waittillmatch(#"_anim_notify_", "hunter02_hit_by_dead");
    level beam::launch(a_ents["hunter"], "tag_fx_jnt", a_ents["hunter"], "drone_02_link_jnt", "dead_turret_beam");
    a_ents["hunter"] waittillmatch(#"_anim_notify_", "hutner02_explodes");
    level beam::kill(a_ents["hunter"], "tag_fx_jnt", a_ents["hunter"], "drone_02_link_jnt", "dead_turret_beam");
}

// Namespace cp_mi_cairo_ramses2
// Params 1, eflags: 0x0
// Checksum 0x7637d993, Offset: 0x1370
// Size: 0xdc
function function_519a7da5(a_ents) {
    a_ents["hunter"] waittillmatch(#"_anim_notify_", "hunter02_b_hit_by_dead");
    level beam::launch(a_ents["hunter"], "tag_fx_b_jnt", a_ents["hunter"], "drone_02_b_link_jnt", "dead_turret_beam");
    a_ents["hunter"] waittillmatch(#"_anim_notify_", "hunter02_b_explodes");
    level beam::kill(a_ents["hunter"], "tag_fx_b_jnt", a_ents["hunter"], "drone_02_b_link_jnt", "dead_turret_beam");
}

// Namespace cp_mi_cairo_ramses2
// Params 1, eflags: 0x0
// Checksum 0x3601bce8, Offset: 0x1458
// Size: 0xdc
function function_e7733d44(a_ents) {
    a_ents["hunter"] waittillmatch(#"_anim_notify_", "hunter03_hit_by_dead");
    level beam::launch(a_ents["hunter"], "tag_fx_jnt", a_ents["hunter"], "drone_03_link_jnt", "dead_turret_beam");
    a_ents["hunter"] waittillmatch(#"_anim_notify_", "hunter03_explodes");
    level beam::kill(a_ents["hunter"], "tag_fx_jnt", a_ents["hunter"], "drone_03_link_jnt", "dead_turret_beam");
}

// Namespace cp_mi_cairo_ramses2
// Params 1, eflags: 0x0
// Checksum 0xd4aaf9d3, Offset: 0x1540
// Size: 0xdc
function function_c170c2db(a_ents) {
    a_ents["hunter"] waittillmatch(#"_anim_notify_", "hunter04_hit_by_dead");
    level beam::launch(a_ents["hunter"], "tag_fx_jnt", a_ents["hunter"], "drone_04_link_jnt", "dead_turret_beam");
    a_ents["hunter"] waittillmatch(#"_anim_notify_", "hunter04_explodes");
    level beam::kill(a_ents["hunter"], "tag_fx_jnt", a_ents["hunter"], "drone_04_link_jnt", "dead_turret_beam");
}

// Namespace cp_mi_cairo_ramses2
// Params 1, eflags: 0x0
// Checksum 0xc9917148, Offset: 0x1628
// Size: 0xdc
function function_9b6e4872(a_ents) {
    a_ents["hunter"] waittillmatch(#"_anim_notify_", "hunter05_hit_by_dead");
    level beam::launch(a_ents["hunter"], "tag_fx_jnt", a_ents["hunter"], "drone_05_link_jnt", "dead_turret_beam");
    a_ents["hunter"] waittillmatch(#"_anim_notify_", "hunter05_explodes");
    level beam::kill(a_ents["hunter"], "tag_fx_jnt", a_ents["hunter"], "drone_05_link_jnt", "dead_turret_beam");
}

// Namespace cp_mi_cairo_ramses2
// Params 1, eflags: 0x0
// Checksum 0x861d6d95, Offset: 0x1710
// Size: 0xdc
function function_756bce09(a_ents) {
    a_ents["turret"] waittillmatch(#"_anim_notify_", "hunter06_hit_by_dead");
    level beam::launch(a_ents["turret"], "tag_fx_01_jnt", a_ents["hunter"], "tag_body", "dead_turret_beam");
    a_ents["turret"] waittillmatch(#"_anim_notify_", "hunter06_explodes");
    level beam::kill(a_ents["turret"], "tag_fx_01_jnt", a_ents["hunter"], "tag_body", "dead_turret_beam");
}

// Namespace cp_mi_cairo_ramses2
// Params 1, eflags: 0x0
// Checksum 0x22eca3c1, Offset: 0x17f8
// Size: 0xdc
function function_4f6953a0(a_ents) {
    a_ents["turret"] waittillmatch(#"_anim_notify_", "hunter07_hit_by_dead");
    level beam::launch(a_ents["turret"], "tag_fx_01_jnt", a_ents["hunter"], "tag_body", "dead_turret_beam");
    a_ents["turret"] waittillmatch(#"_anim_notify_", "hunter07_explodes");
    level beam::kill(a_ents["turret"], "tag_fx_01_jnt", a_ents["hunter"], "tag_body", "dead_turret_beam");
}

// Namespace cp_mi_cairo_ramses2
// Params 1, eflags: 0x0
// Checksum 0xe9eaea5f, Offset: 0x18e0
// Size: 0xdc
function function_898e7fc7(a_ents) {
    a_ents["turret"] waittillmatch(#"_anim_notify_", "hunter08_hit_by_dead");
    level beam::launch(a_ents["turret"], "tag_fx_01_jnt", a_ents["hunter"], "tag_body", "dead_turret_beam");
    a_ents["turret"] waittillmatch(#"_anim_notify_", "hunter08_explodes");
    level beam::kill(a_ents["turret"], "tag_fx_01_jnt", a_ents["hunter"], "tag_body", "dead_turret_beam");
}

// Namespace cp_mi_cairo_ramses2
// Params 1, eflags: 0x0
// Checksum 0xd6d2c069, Offset: 0x19c8
// Size: 0xe4
function function_66424409(a_ents) {
    var_2ef9d306 = a_ents["qt_plaza_palace_wall_vtol"];
    a_ents["turret_palace_wall_collapse"] waittillmatch(#"_anim_notify_", "vtol_hit_by_dead");
    level beam::launch(a_ents["turret_palace_wall_collapse"], "tag_fx_01_jnt", var_2ef9d306, "tag_origin", "dead_turret_beam");
    a_ents["turret_palace_wall_collapse"] waittillmatch(#"_anim_notify_", "vtol_explodes");
    level beam::kill(a_ents["turret_palace_wall_collapse"], "tag_fx_01_jnt", var_2ef9d306, "tag_origin", "dead_turret_beam");
}

// Namespace cp_mi_cairo_ramses2
// Params 1, eflags: 0x0
// Checksum 0x848ca0e3, Offset: 0x1ab8
// Size: 0xdc
function function_a8ab3d99(a_ents) {
    a_ents["turret_vtol_igc"] waittillmatch(#"_anim_notify_", "hunter07_vtol_igc_hit_by_dead");
    level beam::launch(a_ents["turret_vtol_igc"], "tag_fx_01_jnt", a_ents["hunter"], "tag_body", "dead_turret_beam");
    a_ents["turret_vtol_igc"] waittillmatch(#"_anim_notify_", "hunter07_vtol_igc_explodes");
    level beam::kill(a_ents["turret_vtol_igc"], "tag_fx_01_jnt", a_ents["hunter"], "tag_body", "dead_turret_beam");
}

// Namespace cp_mi_cairo_ramses2
// Params 7, eflags: 0x0
// Checksum 0xbea7a267, Offset: 0x1ba0
// Size: 0x6e
function arena_defend_fxanim_hunters(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        level thread function_63225685();
        return;
    }
    level notify(#"hash_73b6a63a");
}

// Namespace cp_mi_cairo_ramses2
// Params 0, eflags: 0x0
// Checksum 0x2efef394, Offset: 0x1c18
// Size: 0xe8
function function_63225685() {
    level endon(#"hash_73b6a63a");
    level thread function_23a3a4e5();
    while (true) {
        wait randomfloatrange(1, 3);
        while (true) {
            var_85e76a39 = randomintrange(1, 6);
            if (!scene::is_playing("p7_fxanim_cp_ramses_lotus_towers_hunters_0" + var_85e76a39 + "_bundle")) {
                break;
            }
            wait 0.1;
        }
        level thread scene::play("p7_fxanim_cp_ramses_lotus_towers_hunters_0" + var_85e76a39 + "_bundle");
    }
}

// Namespace cp_mi_cairo_ramses2
// Params 0, eflags: 0x0
// Checksum 0xfbbd1c9a, Offset: 0x1d08
// Size: 0x168
function function_23a3a4e5() {
    level endon(#"hash_73b6a63a");
    while (true) {
        wait randomfloatrange(1, 3);
        while (true) {
            var_85e76a39 = randomintrange(1, 5);
            if (var_85e76a39 == 4) {
                if (!scene::is_playing("p7_fxanim_cp_ramses_lotus_towers_hunters_peel_off_01_bundle") && !scene::is_playing("p7_fxanim_cp_ramses_lotus_towers_hunters_peel_off_02_bundle")) {
                    break;
                }
            } else if (!scene::is_playing("p7_fxanim_cp_ramses_lotus_towers_hunters_peel_off_0" + var_85e76a39 + "_bundle")) {
                break;
            }
            wait 0.05;
        }
        if (var_85e76a39 == 4) {
            level thread scene::play("p7_fxanim_cp_ramses_lotus_towers_hunters_peel_off_01_bundle");
            scene::play("p7_fxanim_cp_ramses_lotus_towers_hunters_peel_off_02_bundle");
            continue;
        }
        scene::play("p7_fxanim_cp_ramses_lotus_towers_hunters_0" + var_85e76a39 + "_bundle");
    }
}

// Namespace cp_mi_cairo_ramses2
// Params 7, eflags: 0x0
// Checksum 0x1b09d6f2, Offset: 0x1e78
// Size: 0x6e
function alley_fxanim_hunters(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        level thread function_3988a9a2();
        return;
    }
    level notify(#"hash_e72998db");
}

// Namespace cp_mi_cairo_ramses2
// Params 0, eflags: 0x0
// Checksum 0x5410ccc3, Offset: 0x1ef0
// Size: 0xd0
function function_3988a9a2() {
    level endon(#"hash_e72998db");
    while (true) {
        wait randomfloatrange(5, 10);
        while (true) {
            var_85e76a39 = randomintrange(6, 9);
            if (!scene::is_playing("p7_fxanim_cp_ramses_lotus_towers_hunters_0" + var_85e76a39 + "_bundle")) {
                break;
            }
            wait 0.1;
        }
        level thread scene::play("p7_fxanim_cp_ramses_lotus_towers_hunters_0" + var_85e76a39 + "_bundle");
    }
}

// Namespace cp_mi_cairo_ramses2
// Params 7, eflags: 0x0
// Checksum 0xc6e6d0b3, Offset: 0x1fc8
// Size: 0x114
function alley_fxanim_curtains(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        level thread scene::play("p7_fxanim_gp_curtain_torn_center_01_s3_bundle");
        level thread scene::play("p7_fxanim_gp_curtain_torn_left_01_s3_bundle");
        level thread scene::play("p7_fxanim_gp_curtain_torn_right_01_s3_bundle");
        return;
    }
    if (newval == 0) {
        level thread scene::stop("p7_fxanim_gp_curtain_torn_center_01_s3_bundle", 1);
        level thread scene::stop("p7_fxanim_gp_curtain_torn_left_01_s3_bundle", 1);
        level thread scene::stop("p7_fxanim_gp_curtain_torn_right_01_s3_bundle", 1);
    }
}

// Namespace cp_mi_cairo_ramses2
// Params 7, eflags: 0x0
// Checksum 0xf5349df9, Offset: 0x20e8
// Size: 0xa4
function function_ac82c57e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        s_fxanim = struct::get("vtol_igc_fxanim_hunter", "targetname");
        s_fxanim scene::play();
        s_fxanim scene::stop(1);
    }
}

// Namespace cp_mi_cairo_ramses2
// Params 7, eflags: 0x0
// Checksum 0xcf9498a6, Offset: 0x2198
// Size: 0x6e
function qt_plaza_fxanim_hunters(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        level thread function_21f5125d();
        return;
    }
    level notify(#"hash_7b9f74d6");
}

// Namespace cp_mi_cairo_ramses2
// Params 0, eflags: 0x0
// Checksum 0x936c1b8d, Offset: 0x2210
// Size: 0xd0
function function_21f5125d() {
    level endon(#"hash_7b9f74d6");
    var_c02e0aaa = struct::get_array("qt_plaza_hunters", "targetname");
    while (true) {
        wait randomfloatrange(5, 10);
        while (true) {
            s_fxanim = array::random(var_c02e0aaa);
            if (!s_fxanim scene::is_playing()) {
                break;
            }
            wait 0.05;
        }
        s_fxanim scene::play();
    }
}

// Namespace cp_mi_cairo_ramses2
// Params 7, eflags: 0x0
// Checksum 0xb3d7d6c9, Offset: 0x22e8
// Size: 0x1a2
function theater_fxanim_swap(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    assert(isdefined(level.var_10d89562), "<dev string:x28>");
    if (newval == 1) {
        foreach (i, model in level.var_10d89562) {
            hidestaticmodel(model);
            if (i % 25 == 0) {
                wait 0.016;
            }
        }
        return;
    }
    foreach (model in level.var_10d89562) {
        unhidestaticmodel(model);
    }
}

// Namespace cp_mi_cairo_ramses2
// Params 7, eflags: 0x0
// Checksum 0x71e5d4c0, Offset: 0x2498
// Size: 0x9c
function player_spike_plant_postfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self thread postfx::playpostfxbundle("pstfx_dust_chalk");
        self thread postfx::playpostfxbundle("pstfx_dust_concrete");
        return;
    }
    self thread postfx::stoppostfxbundle();
}

// Namespace cp_mi_cairo_ramses2
// Params 7, eflags: 0x0
// Checksum 0x8bcd5c59, Offset: 0x2540
// Size: 0x64
function function_be694d80(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        setexposureactivebank(localclientnum, 2);
    }
}

// Namespace cp_mi_cairo_ramses2
// Params 7, eflags: 0x0
// Checksum 0x6eba078e, Offset: 0x25b0
// Size: 0x1a2
function function_e3a0ff9c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    assert(isdefined(level.var_c6e7f081), "<dev string:x61>");
    if (newval == 1) {
        foreach (i, model in level.var_c6e7f081) {
            hidestaticmodel(model);
            if (i % 25 == 0) {
                wait 0.016;
            }
        }
        return;
    }
    foreach (model in level.var_c6e7f081) {
        unhidestaticmodel(model);
    }
}

// Namespace cp_mi_cairo_ramses2
// Params 7, eflags: 0x0
// Checksum 0x447627ae, Offset: 0x2760
// Size: 0xb4
function hide_statue_rubble(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_98ad2cfe = getent(localclientnum, "quadtank_statue_chunks", "targetname");
    if (isdefined(var_98ad2cfe)) {
        if (newval == 1) {
            var_98ad2cfe hide();
            return;
        }
        var_98ad2cfe show();
    }
}

// Namespace cp_mi_cairo_ramses2
// Params 7, eflags: 0x0
// Checksum 0x6f8e45, Offset: 0x2820
// Size: 0x7e
function alley_fog_banks(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    for (localclientnum = 0; localclientnum < level.localplayers.size; localclientnum++) {
        setworldfogactivebank(localclientnum, 1);
    }
}

