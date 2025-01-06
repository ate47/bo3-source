#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace zm_prototype_barrels;

// Namespace zm_prototype_barrels
// Params 0, eflags: 0x2
// Checksum 0x4632a22b, Offset: 0x200
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_prototype_barrels", &__init__, undefined, undefined);
}

// Namespace zm_prototype_barrels
// Params 0, eflags: 0x0
// Checksum 0x5333241a, Offset: 0x240
// Size: 0x94
function __init__() {
    clientfield::register("scriptmover", "exploding_barrel_burn_fx", 21000, 1, "int", &function_66d46c7d, 0, 0);
    clientfield::register("scriptmover", "exploding_barrel_explode_fx", 21000, 1, "int", &function_b6fe19c5, 0, 0);
}

// Namespace zm_prototype_barrels
// Params 7, eflags: 0x0
// Checksum 0x1e78a8b3, Offset: 0x2e0
// Size: 0x84
function function_66d46c7d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_39bdc445 = playfxontag(localclientnum, level.var_c655ff3a["barrel"]["burn_start"], self, "tag_fx_btm");
    }
}

// Namespace zm_prototype_barrels
// Params 7, eflags: 0x0
// Checksum 0x3abebbd8, Offset: 0x370
// Size: 0xac
function function_b6fe19c5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (isdefined(self.var_39bdc445)) {
            stopfx(localclientnum, self.var_39bdc445);
        }
        self.var_4360e059 = playfxontag(localclientnum, level.var_c655ff3a["barrel"]["explode"], self, "tag_fx_btm");
    }
}

