#using scripts/shared/scene_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace namespace_34269b51;

// Namespace namespace_34269b51
// Params 0, eflags: 0x0
// Checksum 0x71465994, Offset: 0x3b0
// Size: 0x12
function main() {
    init_clientfields();
}

// Namespace namespace_34269b51
// Params 0, eflags: 0x0
// Checksum 0x8514e98a, Offset: 0x3d0
// Size: 0x34a
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
// Params 7, eflags: 0x0
// Checksum 0x1970d8cb, Offset: 0x728
// Size: 0x6e
function function_1d3b6fae(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player = getlocalplayer(localclientnum);
    player postfx::stoppostfxbundle();
    player.var_8afc17fb = 0;
}

// Namespace namespace_34269b51
// Params 7, eflags: 0x0
// Checksum 0x3e68ef49, Offset: 0x7a0
// Size: 0x62
function function_883e8035(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (oldval != newval) {
        if (newval == 1) {
            exploder::exploder("lgt_tree_glow_01");
        }
    }
}

// Namespace namespace_34269b51
// Params 7, eflags: 0x0
// Checksum 0x6226a62f, Offset: 0x810
// Size: 0x62
function function_ae40fa9e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (oldval != newval) {
        if (newval == 1) {
            exploder::exploder("lgt_tree_glow_02");
        }
    }
}

// Namespace namespace_34269b51
// Params 7, eflags: 0x0
// Checksum 0x35943017, Offset: 0x880
// Size: 0x62
function function_d4437507(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (oldval != newval) {
        if (newval == 1) {
            exploder::exploder("lgt_tree_glow_03");
        }
    }
}

// Namespace namespace_34269b51
// Params 7, eflags: 0x0
// Checksum 0x8e05f5f9, Offset: 0x8f0
// Size: 0x62
function function_ca321c28(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (oldval != newval) {
        if (newval == 1) {
            exploder::exploder("lgt_tree_glow_04");
        }
    }
}

// Namespace namespace_34269b51
// Params 7, eflags: 0x0
// Checksum 0x9d5326b6, Offset: 0x960
// Size: 0x7a
function function_f0349691(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (oldval != newval) {
        if (newval == 1) {
            exploder::exploder("lgt_tree_glow_05");
            exploder::exploder("lgt_tree_glow_05_fade_out");
        }
    }
}

// Namespace namespace_34269b51
// Params 7, eflags: 0x0
// Checksum 0xc746dff5, Offset: 0x9e8
// Size: 0x62
function function_c27ea863(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (oldval != newval) {
        if (newval == 1) {
            exploder::stop_exploder("lgt_tree_glow_05_fade_out");
        }
    }
}

// Namespace namespace_34269b51
// Params 7, eflags: 0x0
// Checksum 0xe7096072, Offset: 0xa58
// Size: 0x99
function function_c0197ff(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (oldval != newval) {
        if (newval == 1) {
            for (i = 1; i <= 5; i++) {
                var_a58a7b24 = "lgt_tree_glow_0" + i;
                exploder::stop_exploder(var_a58a7b24);
            }
        }
    }
}

// Namespace namespace_34269b51
// Params 7, eflags: 0x0
// Checksum 0xe28653e0, Offset: 0xb00
// Size: 0xc2
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
// Params 7, eflags: 0x0
// Checksum 0x3f6ad617, Offset: 0xbd0
// Size: 0xc2
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
// Params 7, eflags: 0x0
// Checksum 0xcfd8778a, Offset: 0xca0
// Size: 0xaa
function function_8e717c36(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player = getlocalplayer(localclientnum);
    player.var_8afc17fb = -1;
    player postfx::playpostfxbundle("pstfx_baby_frost_up");
    player postfx::playpostfxbundle("pstfx_baby_frost_loop");
    playsound(0, "evt_freeze_start", (0, 0, 0));
}

// Namespace namespace_34269b51
// Params 7, eflags: 0x0
// Checksum 0xbcd757c0, Offset: 0xd58
// Size: 0x62
function function_9d61ff9d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player = getlocalplayer(localclientnum);
    player thread postfx::exitpostfxbundle();
}

// Namespace namespace_34269b51
// Params 7, eflags: 0x0
// Checksum 0x1da1bfd4, Offset: 0xdc8
// Size: 0x72
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
// Params 7, eflags: 0x0
// Checksum 0xccdee0a9, Offset: 0xe48
// Size: 0x82
function function_8422b90b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!binitialsnap && !bnewent) {
        if (newval != oldval && newval == 1) {
            level thread scene::play("p7_fxanim_cp_infection_baby_bundle");
            exploder::exploder("inf_boa_crying");
        }
    }
}

// Namespace namespace_34269b51
// Params 7, eflags: 0x0
// Checksum 0x1c15d884, Offset: 0xed8
// Size: 0x165
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
        self mapshaderconstant(0, 0, "scriptVector1", var_1d8a2dd1, var_9f45473e, 0, 0);
        self mapshaderconstant(0, 0, "scriptVector0", var_be6c1800, 0, 0);
        wait(0.01);
    }
}

