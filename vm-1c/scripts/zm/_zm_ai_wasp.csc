#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_util;
#using scripts/shared/postfx_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_b1ca30af;

// Namespace namespace_b1ca30af
// Params 0, eflags: 0x2
// namespace_b1ca30af<file_0>::function_2dc19561
// Checksum 0xff10e1bc, Offset: 0x2a8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_ai_wasp", &__init__, undefined, undefined);
}

// Namespace namespace_b1ca30af
// Params 0, eflags: 0x0
// namespace_b1ca30af<file_0>::function_8c87d8eb
// Checksum 0x3b03f70e, Offset: 0x2e8
// Size: 0x11e
function __init__() {
    clientfield::register("toplayer", "parasite_round_fx", 1, 1, "counter", &function_2daf7170, 0, 0);
    clientfield::register("world", "toggle_on_parasite_fog", 1, 2, "int", &function_4c31bb81, 0, 0);
    clientfield::register("toplayer", "parasite_round_ring_fx", 1, 1, "counter", &function_c9063f15, 0, 0);
    visionset_mgr::register_visionset_info("zm_wasp_round_visionset", 1, 31, undefined, "zm_wasp_round_visionset");
    level._effect["parasite_round"] = "zombie/fx_parasite_round_tell_zod_zmb";
}

// Namespace namespace_b1ca30af
// Params 7, eflags: 0x0
// namespace_b1ca30af<file_0>::function_4c31bb81
// Checksum 0x7b13d4de, Offset: 0x410
// Size: 0x116
function function_4c31bb81(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        for (localclientnum = 0; localclientnum < level.localplayers.size; localclientnum++) {
            setlitfogbank(localclientnum, -1, 1, -1);
            setworldfogactivebank(localclientnum, 2);
        }
    }
    if (newval == 2) {
        for (localclientnum = 0; localclientnum < level.localplayers.size; localclientnum++) {
            setlitfogbank(localclientnum, -1, 0, -1);
            setworldfogactivebank(localclientnum, 1);
        }
    }
}

// Namespace namespace_b1ca30af
// Params 7, eflags: 0x0
// namespace_b1ca30af<file_0>::function_2daf7170
// Checksum 0xbda5c7f9, Offset: 0x530
// Size: 0xcc
function function_2daf7170(var_6575414d, var_d5fa7963, var_3a04fa7e, var_3a8c4f80, var_406ad39b, str_field, var_f9aa8824) {
    self endon(#"disconnect");
    self endon(#"death");
    if (isspectating(var_6575414d)) {
        return;
    }
    self.var_44dfdb55 = playfxoncamera(var_6575414d, level._effect["parasite_round"]);
    wait(3.5);
    deletefx(var_6575414d, self.var_44dfdb55);
}

// Namespace namespace_b1ca30af
// Params 7, eflags: 0x0
// namespace_b1ca30af<file_0>::function_c9063f15
// Checksum 0xa882bed6, Offset: 0x608
// Size: 0x9c
function function_c9063f15(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"disconnect");
    if (isspectating(localclientnum)) {
        return;
    }
    self thread postfx::playpostfxbundle("pstfx_ring_loop");
    wait(1.5);
    self postfx::exitpostfxbundle();
}

