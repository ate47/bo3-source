#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/aat_shared;

#namespace zm_aat_turned;

// Namespace zm_aat_turned
// Params 0, eflags: 0x2
// Checksum 0xf81d8648, Offset: 0x190
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_aat_turned", &__init__, undefined, undefined);
}

// Namespace zm_aat_turned
// Params 0, eflags: 0x1 linked
// Checksum 0x392d117a, Offset: 0x1d0
// Size: 0x8c
function __init__() {
    if (!(isdefined(level.aat_in_use) && level.aat_in_use)) {
        return;
    }
    aat::register("zm_aat_turned", "zmui_zm_aat_turned", "t7_icon_zm_aat_turned");
    clientfield::register("actor", "zm_aat_turned", 1, 1, "int", &function_47a93e3e, 0, 0);
}

// Namespace zm_aat_turned
// Params 7, eflags: 0x1 linked
// Checksum 0xdf75bb67, Offset: 0x268
// Size: 0x166
function function_47a93e3e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self setdrawname(makelocalizedstring("zmui_zm_aat_turned"), 1);
        self.var_2c2f1496 = playfxontag(localclientnum, "zombie/fx_glow_eye_green", self, "j_eyeball_le");
        self.var_c4261081 = playfxontag(localclientnum, "zombie/fx_aat_turned_spore_torso_zmb", self, "j_spine4");
        self playsound(localclientnum, "");
        return;
    }
    if (isdefined(self.var_2c2f1496)) {
        stopfx(localclientnum, self.var_2c2f1496);
        self.var_2c2f1496 = undefined;
    }
    if (isdefined(self.var_c4261081)) {
        stopfx(localclientnum, self.var_c4261081);
        self.var_c4261081 = undefined;
    }
}

