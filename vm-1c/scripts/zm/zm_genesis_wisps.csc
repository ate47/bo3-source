#using scripts/zm/zm_genesis_util;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm;
#using scripts/zm/_load;
#using scripts/shared/weapons/_bouncingbetty;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/animation_shared;
#using scripts/codescripts/struct;

#namespace namespace_44f858d8;

// Namespace namespace_44f858d8
// Params 0, eflags: 0x2
// namespace_44f858d8<file_0>::function_2dc19561
// Checksum 0x428f823f, Offset: 0x308
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("zm_genesis_wisps", &__init__, &__main__, undefined);
}

// Namespace namespace_44f858d8
// Params 0, eflags: 0x1 linked
// namespace_44f858d8<file_0>::function_8c87d8eb
// Checksum 0xc5e553eb, Offset: 0x350
// Size: 0x94
function __init__() {
    clientfield::register("toplayer", "set_funfact_fx", 15000, 3, "int", &function_2c251c80, 0, 0);
    clientfield::register("scriptmover", "wisp_fx", 15000, 2, "int", &wisp_fx, 0, 0);
}

// Namespace namespace_44f858d8
// Params 0, eflags: 0x1 linked
// namespace_44f858d8<file_0>::function_5b6b9132
// Checksum 0x99ec1590, Offset: 0x3f0
// Size: 0x4
function __main__() {
    
}

// Namespace namespace_44f858d8
// Params 7, eflags: 0x1 linked
// namespace_44f858d8<file_0>::function_a002f7c1
// Checksum 0xaab4bf93, Offset: 0x400
// Size: 0xbc
function wisp_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        playfxontag(localclientnum, level._effect["wisp_abcd"], self, "tag_origin");
    }
    if (newval == 2) {
        playfxontag(localclientnum, level._effect["wisp_shad"], self, "tag_origin");
    }
}

// Namespace namespace_44f858d8
// Params 7, eflags: 0x1 linked
// namespace_44f858d8<file_0>::function_2c251c80
// Checksum 0xe7c5e163, Offset: 0x4c8
// Size: 0x194
function function_2c251c80(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (!isdefined(self.var_ab2ca08f)) {
            var_6aa3898e = array("stub", "s_fx_funfact_demp", "s_fx_funfact_niko", "s_fx_funfact_rich", "s_fx_funfact_take");
            var_43845c37 = var_6aa3898e[newval];
            s_fx = struct::get(var_43845c37, "targetname");
            if (isdefined(s_fx)) {
                self.var_ab2ca08f = util::spawn_model(localclientnum, "tag_origin", s_fx.origin, s_fx.angles);
                if (isdefined(self.var_ab2ca08f)) {
                    playfxontag(localclientnum, level._effect["wisp_abcd"], self.var_ab2ca08f, "tag_origin");
                }
            }
        }
        return;
    }
    if (isdefined(self.var_ab2ca08f)) {
        self.var_ab2ca08f delete();
    }
}

