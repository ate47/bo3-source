#using scripts/zm/zm_genesis_util;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm;
#using scripts/zm/_load;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/shared/animation_shared;
#using scripts/codescripts/struct;

#namespace namespace_c30b09d6;

// Namespace namespace_c30b09d6
// Params 0, eflags: 0x2
// Checksum 0x4f1d2e7, Offset: 0x358
// Size: 0x34
function function_2dc19561() {
    system::register("zm_genesis_hope", &__init__, undefined, undefined);
}

// Namespace namespace_c30b09d6
// Params 0, eflags: 0x0
// Checksum 0xef1fa365, Offset: 0x398
// Size: 0x13c
function __init__() {
    level._effect["spark_of_hope"] = "dlc4/genesis/fx_quest_hope";
    clientfield::register("world", "hope_state", 15000, getminbitcountfornum(4), "int", &function_7341c96b, 0, 0);
    clientfield::register("clientuimodel", "zmInventory.super_ee", 15000, 1, "int", undefined, 0, 0);
    clientfield::register("toplayer", "hope_spark", 15000, 1, "int", &function_2e70599d, 0, 0);
    clientfield::register("scriptmover", "hope_spark", 15000, 1, "int", &function_2e70599d, 0, 0);
}

// Namespace namespace_c30b09d6
// Params 7, eflags: 0x0
// Checksum 0x4ec202b2, Offset: 0x4e0
// Size: 0x156
function function_7341c96b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level notify(#"hash_89f142a1");
    level endon(#"hash_89f142a1");
    var_d461c73e = struct::get("hope_spark", "targetname");
    switch (newval) {
    case 0:
        var_d461c73e thread function_5f968055(localclientnum, 0);
        break;
    case 1:
        var_d461c73e thread function_5f968055(localclientnum, 1);
        break;
    case 2:
        var_d461c73e thread function_5f968055(localclientnum, 0);
        break;
    case 3:
        var_d461c73e thread function_5f968055(localclientnum, 0);
        audio::playloopat("zmb_overachiever_musicbox_lp", (-6147, -54, -94));
        break;
    }
}

// Namespace namespace_c30b09d6
// Params 7, eflags: 0x0
// Checksum 0xd1103e4d, Offset: 0x640
// Size: 0x106
function function_2e70599d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_c9725bbd = playfxontag(localclientnum, level._effect["spark_of_hope"], self, "j_spine4");
        self.var_d0642fb4 = self playloopsound("zmb_overachiever_spark_lp", 1);
        return;
    }
    if (isdefined(self.var_c9725bbd)) {
        stopfx(localclientnum, self.var_c9725bbd);
    }
    if (isdefined(self.var_d0642fb4)) {
        self stoploopsound(self.var_d0642fb4);
        self.var_d0642fb4 = undefined;
    }
}

// Namespace namespace_c30b09d6
// Params 2, eflags: 0x0
// Checksum 0x5007424c, Offset: 0x750
// Size: 0xec
function function_5f968055(localclientnum, b_on) {
    if (isdefined(self.var_c9725bbd)) {
        stopfx(localclientnum, self.var_c9725bbd);
    }
    if (b_on) {
        self.var_c9725bbd = playfx(localclientnum, level._effect["spark_of_hope"], self.origin);
        playsound(0, "zmb_overachiever_spark_spawn", self.origin);
        audio::playloopat("zmb_overachiever_spark_lp_3d", self.origin);
        return;
    }
    audio::stoploopat("zmb_overachiever_spark_lp_3d", self.origin);
}

