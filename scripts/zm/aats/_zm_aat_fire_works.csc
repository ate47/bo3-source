#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/aat_shared;

#namespace namespace_a7e7ef63;

// Namespace namespace_a7e7ef63
// Params 0, eflags: 0x2
// Checksum 0x466d6962, Offset: 0x168
// Size: 0x34
function function_2dc19561() {
    system::register("zm_aat_fire_works", &__init__, undefined, undefined);
}

// Namespace namespace_a7e7ef63
// Params 0, eflags: 0x1 linked
// Checksum 0x8db38e05, Offset: 0x1a8
// Size: 0xa6
function __init__() {
    if (!(isdefined(level.aat_in_use) && level.aat_in_use)) {
        return;
    }
    aat::register("zm_aat_fire_works", "zmui_zm_aat_fire_works", "t7_icon_zm_aat_fire_works");
    clientfield::register("scriptmover", "zm_aat_fire_works", 1, 1, "int", &function_272fb293, 0, 0);
    level._effect["zm_aat_fire_works"] = "zombie/fx_aat_fireworks_zmb";
}

// Namespace namespace_a7e7ef63
// Params 7, eflags: 0x1 linked
// Checksum 0xf595ef0e, Offset: 0x258
// Size: 0x116
function function_272fb293(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_ef7f4c58 = playfx(localclientnum, "zombie/fx_aat_fireworks_zmb", self.origin, anglestoforward(self.angles));
        playsound(localclientnum, "wpn_aat_firework_explo", self.origin);
        if (isdemoplaying()) {
            self thread function_fe7e2587(localclientnum);
        }
        return;
    }
    if (isdefined(self.var_ef7f4c58)) {
        self notify(#"hash_fe7e2587");
        stopfx(localclientnum, self.var_ef7f4c58);
        self.var_ef7f4c58 = undefined;
    }
}

// Namespace namespace_a7e7ef63
// Params 1, eflags: 0x1 linked
// Checksum 0x68a80b30, Offset: 0x378
// Size: 0x66
function function_fe7e2587(localclientnum) {
    self notify(#"hash_fe7e2587");
    self endon(#"hash_fe7e2587");
    level waittill(#"demo_jump");
    if (isdefined(self.var_ef7f4c58)) {
        stopfx(localclientnum, self.var_ef7f4c58);
        self.var_ef7f4c58 = undefined;
    }
}

