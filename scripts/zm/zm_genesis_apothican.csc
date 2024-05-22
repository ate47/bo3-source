#using scripts/shared/system_shared;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm;
#using scripts/zm/_load;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/postfx_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/shared/animation_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace namespace_a9c2433b;

// Namespace namespace_a9c2433b
// Params 0, eflags: 0x2
// Checksum 0x316bd226, Offset: 0x4a0
// Size: 0x34
function function_2dc19561() {
    system::register("zm_genesis_apothican", &__init__, undefined, undefined);
}

// Namespace namespace_a9c2433b
// Params 0, eflags: 0x0
// Checksum 0xfc2a0099, Offset: 0x4e0
// Size: 0x2e8
function __init__() {
    clientfield::register("allplayers", "apothicon_player_keyline", 15000, 1, "int", &function_d1bce8c4, 0, 0);
    clientfield::register("toplayer", "apothicon_entry_postfx", 15000, 1, "int", &function_564acc2a, 0, 0);
    clientfield::register("world", "gas_fog_bank_switch", 15000, 1, "int", &function_e7d87449, 0, 0);
    clientfield::register("scriptmover", "egg_spawn_fx", 15000, 1, "int", &function_bcc1c00d, 0, 0);
    clientfield::register("scriptmover", "gateworm_mtl", 15000, 1, "int", &function_52756c39, 0, 0);
    clientfield::register("toplayer", "player_apothicon_egg", 15000, 1, "int", &zm_utility::setinventoryuimodels, 0, 0);
    clientfield::register("clientuimodel", "zmInventory.widget_apothicon_egg", 15000, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "zmInventory.player_apothicon_egg_bg", 15000, 1, "int", undefined, 0, 0);
    clientfield::register("toplayer", "player_gate_worm", 15000, 1, "int", &zm_utility::setinventoryuimodels, 0, 0);
    clientfield::register("clientuimodel", "zmInventory.widget_gate_worm", 15000, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "zmInventory.player_gate_worm_bg", 15000, 1, "int", undefined, 0, 0);
    level.var_e8af7a2f = 0;
}

// Namespace namespace_a9c2433b
// Params 5, eflags: 0x0
// Checksum 0x21b3dd22, Offset: 0x7d0
// Size: 0xb4
function function_b77a78c9(localclientnum, str_fx, v_origin, n_duration, v_angles) {
    if (isdefined(v_angles)) {
        fx = playfx(localclientnum, str_fx, v_origin, v_angles);
    } else {
        fx = playfx(localclientnum, str_fx, v_origin);
    }
    wait(n_duration);
    stopfx(localclientnum, fx);
}

// Namespace namespace_a9c2433b
// Params 2, eflags: 0x0
// Checksum 0x52cb4414, Offset: 0x890
// Size: 0x7c
function scene_play(scene, mdl_pod) {
    self notify(#"scene_play");
    self endon(#"scene_play");
    self scene::stop();
    self function_6221b6b9(scene, mdl_pod);
    self scene::stop();
}

// Namespace namespace_a9c2433b
// Params 2, eflags: 0x0
// Checksum 0x38d0bce1, Offset: 0x918
// Size: 0x3c
function function_6221b6b9(scene, mdl_pod) {
    level endon(#"demo_jump");
    self scene::play(scene, mdl_pod);
}

// Namespace namespace_a9c2433b
// Params 7, eflags: 0x0
// Checksum 0xf99edd72, Offset: 0x960
// Size: 0x10c
function function_d1bce8c4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isspectating(localclientnum) && self islocalplayer() && localclientnum == self getlocalclientnumber()) {
        return;
    }
    if (newval == 1) {
        self duplicate_render::set_dr_flag("keyline_active", 0);
        self duplicate_render::update_dr_filters(localclientnum);
        return;
    }
    self duplicate_render::set_dr_flag("keyline_active", 1);
    self duplicate_render::update_dr_filters(localclientnum);
}

// Namespace namespace_a9c2433b
// Params 7, eflags: 0x0
// Checksum 0x9c38c598, Offset: 0xa78
// Size: 0x122
function function_564acc2a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self notify(#"hash_564acc2a");
    self endon(#"hash_564acc2a");
    if (newval == 1) {
        if (isdemoplaying() && demoisanyfreemovecamera()) {
            return;
        }
        self thread function_e7a8756e(localclientnum);
        self thread postfx::playpostfxbundle("pstfx_gen_apothicon_swallow");
        playsound(0, "zmb_apothigod_mouth_start", (0, 0, 0));
        return;
    }
    playsound(0, "zmb_apothigod_mouth_eject", (0, 0, 0));
    self notify(#"hash_44b2f5f");
}

// Namespace namespace_a9c2433b
// Params 1, eflags: 0x0
// Checksum 0x4b62cac9, Offset: 0xba8
// Size: 0x4c
function function_e7a8756e(localclientnum) {
    self util::waittill_any("apothicon_entry_postfx", "apothicon_entry_complete");
    self postfx::exitpostfxbundle();
}

// Namespace namespace_a9c2433b
// Params 7, eflags: 0x0
// Checksum 0xa8faa3a7, Offset: 0xc00
// Size: 0x140
function function_e7d87449(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        level.var_e8af7a2f = 1;
        for (localclientnum = 0; localclientnum < level.localplayers.size; localclientnum++) {
            if (level.var_b7572a82) {
                setworldfogactivebank(localclientnum, 8);
                continue;
            }
            setworldfogactivebank(localclientnum, 4);
        }
        return;
    }
    for (localclientnum = 0; localclientnum < level.localplayers.size; localclientnum++) {
        if (level.var_b7572a82) {
            setworldfogactivebank(localclientnum, 2);
            continue;
        }
        setworldfogactivebank(localclientnum, 1);
    }
    level.var_e8af7a2f = 0;
}

// Namespace namespace_a9c2433b
// Params 7, eflags: 0x0
// Checksum 0xf845da25, Offset: 0xd48
// Size: 0xbe
function function_bcc1c00d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_70a0d336 = playfxontag(localclientnum, level._effect["egg_spawn_fx"], self, "tag_origin");
        return;
    }
    if (isdefined(self) && isdefined(self.var_70a0d336)) {
        stopfx(localclientnum, self.var_70a0d336);
        self.var_70a0d336 = undefined;
    }
}

// Namespace namespace_a9c2433b
// Params 7, eflags: 0x0
// Checksum 0x5a378efd, Offset: 0xe10
// Size: 0x64
function function_52756c39(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self mapshaderconstant(localclientnum, 0, "scriptVector2", 1, 0, 0);
}

