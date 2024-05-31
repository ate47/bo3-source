#using scripts/shared/scene_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace namespace_34269b51;

// Namespace namespace_34269b51
// Params 0, eflags: 0x1 linked
// namespace_34269b51<file_0>::function_d290ebfa
// Checksum 0x95d07426, Offset: 0x3b0
// Size: 0x14
function main() {
    init_clientfields();
}

// Namespace namespace_34269b51
// Params 0, eflags: 0x1 linked
// namespace_34269b51<file_0>::function_2ea898a8
// Checksum 0xaf5000fc, Offset: 0x3d0
// Size: 0x43c
function init_clientfields() {
    clientfield::register("toplayer", "sim_out_of_bound", 1, 1, "counter", &function_1d3b6fae, 0, 0);
    clientfield::register("world", "sim_lgt_tree_glow_01", 1, 1, "int", &function_883e8035, 0, 0);
    clientfield::register("world", "sim_lgt_tree_glow_02", 1, 1, "int", &function_ae40fa9e, 0, 0);
    clientfield::register("world", "sim_lgt_tree_glow_03", 1, 1, "int", &function_d4437507, 0, 0);
    clientfield::register("world", "sim_lgt_tree_glow_04", 1, 1, "int", &function_ca321c28, 0, 0);
    clientfield::register("world", "sim_lgt_tree_glow_05", 1, 1, "int", &function_f0349691, 0, 0);
    clientfield::register("world", "lgt_tree_glow_05_fade_out", 1, 1, "int", &function_c27ea863, 0, 0);
    clientfield::register("world", "sim_lgt_tree_glow_all_off", 1, 1, "int", &function_c0197ff, 0, 0);
    clientfield::register("toplayer", "pstfx_frost_up", 1, 1, "counter", &function_fa9ecbf7, 0, 0);
    clientfield::register("toplayer", "pstfx_frost_down", 1, 1, "counter", &function_a34472c4, 0, 0);
    clientfield::register("toplayer", "pstfx_frost_up_baby", 1, 1, "counter", &function_8e717c36, 0, 0);
    clientfield::register("toplayer", "pstfx_exit_all", 1, 1, "counter", &function_9d61ff9d, 0, 0);
    clientfield::register("scriptmover", "infection_baby_shader", 1, 1, "int", &function_e43dc74b, 0, 0);
    clientfield::register("world", "toggle_sim_fog_banks", 1, 1, "int", &function_972dc8a2, 0, 0);
    clientfield::register("world", "break_baby", 1, 1, "int", &function_8422b90b, 0, 0);
}

// Namespace namespace_34269b51
// Params 7, eflags: 0x1 linked
// namespace_34269b51<file_0>::function_1d3b6fae
// Checksum 0x1f7abec8, Offset: 0x818
// Size: 0x84
function function_1d3b6fae(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player = getlocalplayer(localclientnum);
    player postfx::stoppostfxbundle();
    player.var_8afc17fb = 0;
}

// Namespace namespace_34269b51
// Params 7, eflags: 0x1 linked
// namespace_34269b51<file_0>::function_883e8035
// Checksum 0xa7cf8500, Offset: 0x8a8
// Size: 0x64
function function_883e8035(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        exploder::exploder("lgt_tree_glow_01");
    }
}

// Namespace namespace_34269b51
// Params 7, eflags: 0x1 linked
// namespace_34269b51<file_0>::function_ae40fa9e
// Checksum 0xecc7db1a, Offset: 0x918
// Size: 0x64
function function_ae40fa9e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        exploder::exploder("lgt_tree_glow_02");
    }
}

// Namespace namespace_34269b51
// Params 7, eflags: 0x1 linked
// namespace_34269b51<file_0>::function_d4437507
// Checksum 0x9abee95a, Offset: 0x988
// Size: 0x64
function function_d4437507(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        exploder::exploder("lgt_tree_glow_03");
    }
}

// Namespace namespace_34269b51
// Params 7, eflags: 0x1 linked
// namespace_34269b51<file_0>::function_ca321c28
// Checksum 0x66df0c3b, Offset: 0x9f8
// Size: 0x64
function function_ca321c28(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        exploder::exploder("lgt_tree_glow_04");
    }
}

// Namespace namespace_34269b51
// Params 7, eflags: 0x1 linked
// namespace_34269b51<file_0>::function_f0349691
// Checksum 0xa1b3e543, Offset: 0xa68
// Size: 0x7c
function function_f0349691(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        exploder::exploder("lgt_tree_glow_05");
        exploder::exploder("lgt_tree_glow_05_fade_out");
    }
}

// Namespace namespace_34269b51
// Params 7, eflags: 0x1 linked
// namespace_34269b51<file_0>::function_c27ea863
// Checksum 0xfe1ac881, Offset: 0xaf0
// Size: 0x64
function function_c27ea863(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        exploder::stop_exploder("lgt_tree_glow_05_fade_out");
    }
}

// Namespace namespace_34269b51
// Params 7, eflags: 0x1 linked
// namespace_34269b51<file_0>::function_c0197ff
// Checksum 0x3d882ca0, Offset: 0xb60
// Size: 0xae
function function_c0197ff(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        for (i = 1; i <= 5; i++) {
            var_a58a7b24 = "lgt_tree_glow_0" + i;
            exploder::stop_exploder(var_a58a7b24);
        }
    }
}

// Namespace namespace_34269b51
// Params 7, eflags: 0x1 linked
// namespace_34269b51<file_0>::function_fa9ecbf7
// Checksum 0xcb80b589, Offset: 0xc18
// Size: 0xfc
function function_fa9ecbf7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player = getlocalplayer(localclientnum);
    if (!isdefined(player.var_8afc17fb)) {
        player.var_8afc17fb = 0;
    }
    if (player.var_8afc17fb == 0 && newval == 1) {
        playsound(0, "evt_freeze_start", (0, 0, 0));
        player.var_8afc17fb = 1;
        player postfx::playpostfxbundle("pstfx_frost_loop");
    }
}

// Namespace namespace_34269b51
// Params 7, eflags: 0x1 linked
// namespace_34269b51<file_0>::function_a34472c4
// Checksum 0xc3999d9e, Offset: 0xd20
// Size: 0xf4
function function_a34472c4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player = getlocalplayer(localclientnum);
    if (!isdefined(player.var_8afc17fb)) {
        player.var_8afc17fb = 0;
    }
    if (player.var_8afc17fb == 1 && newval == 1) {
        playsound(0, "evt_freeze_end", (0, 0, 0));
        player.var_8afc17fb = 0;
        player thread postfx::exitpostfxbundle();
    }
}

// Namespace namespace_34269b51
// Params 7, eflags: 0x1 linked
// namespace_34269b51<file_0>::function_8e717c36
// Checksum 0xdf7cba4d, Offset: 0xe20
// Size: 0xd4
function function_8e717c36(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player = getlocalplayer(localclientnum);
    player.var_8afc17fb = -1;
    player postfx::playpostfxbundle("pstfx_baby_frost_up");
    player postfx::playpostfxbundle("pstfx_baby_frost_loop");
    playsound(0, "evt_freeze_start", (0, 0, 0));
}

// Namespace namespace_34269b51
// Params 7, eflags: 0x1 linked
// namespace_34269b51<file_0>::function_9d61ff9d
// Checksum 0x546d9b38, Offset: 0xf00
// Size: 0x74
function function_9d61ff9d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player = getlocalplayer(localclientnum);
    player thread postfx::exitpostfxbundle();
}

// Namespace namespace_34269b51
// Params 7, eflags: 0x1 linked
// namespace_34269b51<file_0>::function_972dc8a2
// Checksum 0xeff5380d, Offset: 0xf80
// Size: 0x8c
function function_972dc8a2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_4780a11e = 0;
    if (newval == 1) {
        var_4780a11e = 2;
    } else {
        var_4780a11e = 0;
    }
    setworldfogactivebank(localclientnum, var_4780a11e);
}

// Namespace namespace_34269b51
// Params 7, eflags: 0x1 linked
// namespace_34269b51<file_0>::function_8422b90b
// Checksum 0xbcd6914c, Offset: 0x1018
// Size: 0xa4
function function_8422b90b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!binitialsnap && !bnewent) {
        if (newval != oldval && newval == 1) {
            level thread scene::play("p7_fxanim_cp_infection_baby_bundle");
            exploder::exploder("inf_boa_crying");
        }
    }
}

// Namespace namespace_34269b51
// Params 7, eflags: 0x1 linked
// namespace_34269b51<file_0>::function_e43dc74b
// Checksum 0xb3d40d34, Offset: 0x10c8
// Size: 0x1f0
function function_e43dc74b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    start_time = gettime();
    anim_time = 15;
    var_ea6e99fe = 2;
    var_88baa01e = 3;
    updating = 1;
    while (updating) {
        time = gettime();
        var_e65455e6 = (time - start_time) / 1000;
        if (var_e65455e6 >= anim_time) {
            var_e65455e6 = anim_time;
            updating = 0;
        }
        var_1d8a2dd1 = var_e65455e6 / 15;
        if (var_e65455e6 < var_ea6e99fe) {
            var_9f45473e = 0;
        } else {
            var_9f45473e = 1 - (15 - var_e65455e6) / (anim_time - var_ea6e99fe);
        }
        if (var_e65455e6 < var_88baa01e) {
            var_be6c1800 = 0;
        } else {
            var_be6c1800 = 1 - (15 - var_e65455e6) / (anim_time - var_88baa01e);
        }
        self mapshaderconstant(localclientnum, 0, "scriptVector1", var_1d8a2dd1, var_9f45473e, 0, 0);
        self mapshaderconstant(localclientnum, 0, "scriptVector0", var_be6c1800, 0, 0);
        wait(0.01);
    }
}

