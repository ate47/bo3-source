#using scripts/shared/system_shared;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm;
#using scripts/zm/_load;
#using scripts/shared/postfx_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/shared/animation_shared;
#using scripts/codescripts/struct;

#namespace namespace_766d6099;

// Namespace namespace_766d6099
// Params 0, eflags: 0x2
// Checksum 0x146ec814, Offset: 0x568
// Size: 0x34
function function_2dc19561() {
    system::register("zm_genesis_portals", &__init__, undefined, undefined);
}

// Namespace namespace_766d6099
// Params 0, eflags: 0x0
// Checksum 0x970e7e6f, Offset: 0x5a8
// Size: 0x464
function __init__() {
    visionset_mgr::register_overlay_info_style_transported("zm_zod", 15000, 15, 2);
    clientfield::register("toplayer", "player_stargate_fx", 15000, 1, "int", &player_stargate_fx, 0, 0);
    clientfield::register("toplayer", "player_light_exploder", 15000, 4, "int", &function_c4b73c11, 0, 0);
    clientfield::register("world", "genesis_light_exposure", 15000, 1, "int", &function_d4327374, 0, 0);
    clientfield::register("world", "power_pad_sheffield", 15000, 1, "int", &function_7e1ae25a, 0, 0);
    clientfield::register("world", "power_pad_prison", 15000, 1, "int", &function_7e1ae25a, 0, 0);
    clientfield::register("world", "power_pad_asylum", 15000, 1, "int", &function_7e1ae25a, 0, 0);
    clientfield::register("world", "power_pad_temple", 15000, 1, "int", &function_7e1ae25a, 0, 0);
    clientfield::register("toplayer", "hint_verruckt_portal_top", 15000, 1, "int", &function_44c843d5, 0, 0);
    clientfield::register("toplayer", "hint_verruckt_portal_bottom", 15000, 1, "int", &function_44c843d5, 0, 0);
    clientfield::register("toplayer", "hint_temple_portal_top", 15000, 1, "int", &function_44c843d5, 0, 0);
    clientfield::register("toplayer", "hint_temple_portal_bottom", 15000, 1, "int", &function_44c843d5, 0, 0);
    clientfield::register("toplayer", "hint_sheffield_portal_top", 15000, 1, "int", &function_44c843d5, 0, 0);
    clientfield::register("toplayer", "hint_sheffield_portal_bottom", 15000, 1, "int", &function_44c843d5, 0, 0);
    clientfield::register("toplayer", "hint_prison_portal_top", 15000, 1, "int", &function_44c843d5, 0, 0);
    clientfield::register("toplayer", "hint_prison_portal_bottom", 15000, 1, "int", &function_44c843d5, 0, 0);
}

// Namespace namespace_766d6099
// Params 7, eflags: 0x0
// Checksum 0x5b09edd, Offset: 0xa18
// Size: 0xde
function player_stargate_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self notify(#"player_stargate_fx");
    self endon(#"player_stargate_fx");
    if (newval == 1) {
        if (isdemoplaying() && demoisanyfreemovecamera()) {
            return;
        }
        self thread function_e7a8756e(localclientnum);
        self thread postfx::playpostfxbundle("pstfx_zm_wormhole");
        return;
    }
    self notify(#"hash_ee477153");
}

// Namespace namespace_766d6099
// Params 1, eflags: 0x0
// Checksum 0x5924945f, Offset: 0xb00
// Size: 0x4c
function function_e7a8756e(localclientnum) {
    self util::waittill_any("player_stargate_fx", "player_portal_complete");
    self postfx::exitpostfxbundle();
}

// Namespace namespace_766d6099
// Params 7, eflags: 0x0
// Checksum 0x90f4ca8c, Offset: 0xb58
// Size: 0x1de
function function_c4b73c11(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    switch (newval) {
    case 1:
        exploder::exploder("lgt_island_underside_sheff", localclientnum);
        break;
    case 2:
        exploder::stop_exploder("lgt_island_underside_sheff", localclientnum);
        break;
    case 3:
        exploder::exploder("lgt_island_underside_prison", localclientnum);
        break;
    case 4:
        exploder::stop_exploder("lgt_island_underside_prison", localclientnum);
        break;
    case 5:
        exploder::exploder("lgt_island_underside_asylum", localclientnum);
        break;
    case 6:
        exploder::stop_exploder("lgt_island_underside_asylum", localclientnum);
        break;
    case 7:
        exploder::exploder("lgt_island_underside_temple", localclientnum);
        break;
    case 8:
        exploder::stop_exploder("lgt_island_underside_temple", localclientnum);
        break;
    case 9:
        exploder::exploder("lgt_island_underside_proto", localclientnum);
        break;
    case 10:
        exploder::stop_exploder("lgt_island_underside_proto", localclientnum);
        break;
    }
}

// Namespace namespace_766d6099
// Params 7, eflags: 0x0
// Checksum 0x146146c6, Offset: 0xd40
// Size: 0xb4
function function_d4327374(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        setpbgactivebank(localclientnum, 2);
        setexposureactivebank(localclientnum, 2);
        return;
    }
    setpbgactivebank(localclientnum, 1);
    setexposureactivebank(localclientnum, 1);
}

// Namespace namespace_766d6099
// Params 7, eflags: 0x0
// Checksum 0x25b6ec63, Offset: 0xe00
// Size: 0x7c
function function_44c843d5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        setstreamerrequest(localclientnum, fieldname);
        return;
    }
    clearstreamerrequest(localclientnum);
}

// Namespace namespace_766d6099
// Params 7, eflags: 0x0
// Checksum 0xdc270e20, Offset: 0xe88
// Size: 0x262
function function_7e1ae25a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    switch (fieldname) {
    case 9:
        var_2cedcd81 = array("fxexp_220", "fxexp_222", "fxexp_223", "lgt_power_prison");
        break;
    case 8:
        var_2cedcd81 = array("fxexp_210", "fxexp_212", "fxexp_213", "lgt_power_sheffield");
        break;
    case 11:
        var_2cedcd81 = array("fxexp_240", "fxexp_242", "fxexp_243", "lgt_power_temple");
        break;
    case 10:
        var_2cedcd81 = array("fxexp_230", "fxexp_232", "fxexp_233", "lgt_power_asylum");
        break;
    }
    if (newval) {
        foreach (str_exploder in var_2cedcd81) {
            exploder::exploder(str_exploder);
        }
        return;
    }
    foreach (str_exploder in var_2cedcd81) {
        exploder::stop_exploder(str_exploder);
    }
}

