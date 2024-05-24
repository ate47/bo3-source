#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_ed811526;

// Namespace namespace_ed811526
// Params 0, eflags: 0x2
// Checksum 0xb5a7f82c, Offset: 0x228
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_stalingrad_challenges", &__init__, undefined, undefined);
}

// Namespace namespace_ed811526
// Params 0, eflags: 0x0
// Checksum 0x69ac929c, Offset: 0x268
// Size: 0x288
function __init__() {
    clientfield::register("toplayer", "challenge1state", 15000, 2, "int", &function_4ff59189, 0, 0);
    clientfield::register("toplayer", "challenge2state", 15000, 2, "int", &function_4ff59189, 0, 0);
    clientfield::register("toplayer", "challenge3state", 15000, 2, "int", &function_4ff59189, 0, 0);
    clientfield::register("toplayer", "challenge_board_eyes", 15000, 1, "int", &function_1664174d, 0, 0);
    clientfield::register("scriptmover", "challenge_board_base", 15000, 1, "int", &function_aae53847, 0, 0);
    clientfield::register("scriptmover", "challenge_board_reward", 15000, 1, "int", &function_2494cf3d, 0, 0);
    level.var_3c3a1522 = [];
    for (x = 0; x < 4; x++) {
        str_name = "challenge_board_" + x;
        if (!isdefined(level.var_3c3a1522)) {
            level.var_3c3a1522 = [];
        } else if (!isarray(level.var_3c3a1522)) {
            level.var_3c3a1522 = array(level.var_3c3a1522);
        }
        level.var_3c3a1522[level.var_3c3a1522.size] = struct::get(str_name);
    }
}

// Namespace namespace_ed811526
// Params 7, eflags: 0x0
// Checksum 0x104ba44a, Offset: 0x4f8
// Size: 0xbc
function function_4ff59189(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isspectating(localclientnum)) {
        return;
    }
    var_42bfa7b6 = getuimodel(getuimodelforcontroller(localclientnum), "trialWidget." + fieldname);
    if (isdefined(var_42bfa7b6)) {
        setuimodelvalue(var_42bfa7b6, newval);
    }
}

// Namespace namespace_ed811526
// Params 7, eflags: 0x0
// Checksum 0xd57104c8, Offset: 0x5c0
// Size: 0x226
function function_1664174d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_a879fa43 = self getentitynumber();
    str_name = "challenge_board_" + var_a879fa43;
    s_skull = struct::get(str_name, "targetname");
    foreach (s_skull in level.var_3c3a1522) {
        if (!isdefined(s_skull.var_90369c89)) {
            s_skull.var_90369c89 = [];
        }
        if (s_skull.script_int == self getentitynumber()) {
            if (!isdefined(s_skull.var_90369c89[localclientnum])) {
                s_skull.var_90369c89[localclientnum] = playfx(localclientnum, level._effect["skull_eyes"], s_skull.origin, anglestoforward(s_skull.angles));
            }
            continue;
        }
        if (isdefined(s_skull.var_90369c89[localclientnum])) {
            deletefx(localclientnum, s_skull.var_90369c89[localclientnum]);
            s_skull.var_90369c89[localclientnum] = undefined;
        }
    }
}

// Namespace namespace_ed811526
// Params 7, eflags: 0x0
// Checksum 0x5c046e5b, Offset: 0x7f0
// Size: 0x6c
function function_aae53847(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playfxontag(localclientnum, level._effect["challenge_base"], self, "tag_fx_box_base");
}

// Namespace namespace_ed811526
// Params 7, eflags: 0x0
// Checksum 0x5a0cd566, Offset: 0x868
// Size: 0xbc
function function_2494cf3d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (!isdefined(self.n_fx_id)) {
            self.n_fx_id = playfxontag(localclientnum, level._effect["challenge_reward"], self, "tag_fx_box_base");
        }
        return;
    }
    if (isdefined(self.n_fx_id)) {
        stopfx(localclientnum, self.n_fx_id);
    }
}

