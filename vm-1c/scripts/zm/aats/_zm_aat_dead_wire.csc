#using scripts/shared/aat_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;

#namespace zm_aat_dead_wire;

// Namespace zm_aat_dead_wire
// Params 0, eflags: 0x2
// Checksum 0x9cfeeb5e, Offset: 0x180
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_aat_dead_wire", &__init__, undefined, undefined);
}

// Namespace zm_aat_dead_wire
// Params 0, eflags: 0x0
// Checksum 0x5b92a17, Offset: 0x1c0
// Size: 0xfe
function __init__() {
    if (!(isdefined(level.aat_in_use) && level.aat_in_use)) {
        return;
    }
    aat::register("zm_aat_dead_wire", "zmui_zm_aat_dead_wire", "t7_icon_zm_aat_dead_wire");
    clientfield::register("actor", "zm_aat_dead_wire" + "_zap", 1, 1, "int", &function_522b211a, 0, 0);
    clientfield::register("vehicle", "zm_aat_dead_wire" + "_zap_vehicle", 1, 1, "int", &function_f1245d3, 0, 0);
    level._effect["zm_aat_dead_wire"] = "zombie/fx_tesla_shock_zmb";
}

// Namespace zm_aat_dead_wire
// Params 7, eflags: 0x0
// Checksum 0xbd3e1b38, Offset: 0x2c8
// Size: 0xae
function function_522b211a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_6486d6cb = playfxontag(localclientnum, "zombie/fx_tesla_shock_zmb", self, "J_SpineUpper");
        return;
    }
    if (isdefined(self.var_6486d6cb)) {
        stopfx(localclientnum, self.var_6486d6cb);
        self.var_6486d6cb = undefined;
    }
}

// Namespace zm_aat_dead_wire
// Params 7, eflags: 0x0
// Checksum 0x2930a5a2, Offset: 0x380
// Size: 0xfe
function function_f1245d3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        tag = "tag_body";
        v_tag = self gettagorigin(tag);
        if (!isdefined(v_tag)) {
            tag = "tag_origin";
        }
        self.var_6486d6cb = playfxontag(localclientnum, "zombie/fx_tesla_shock_zmb", self, tag);
        return;
    }
    if (isdefined(self.var_6486d6cb)) {
        stopfx(localclientnum, self.var_6486d6cb);
        self.var_6486d6cb = undefined;
    }
}

