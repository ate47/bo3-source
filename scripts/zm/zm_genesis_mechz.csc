#using scripts/shared/system_shared;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm;
#using scripts/zm/_load;
#using scripts/shared/util_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_8f77dbcb;

// Namespace namespace_8f77dbcb
// Params 0, eflags: 0x2
// Checksum 0xf7c34f46, Offset: 0x2b0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_genesis_mechz", &__init__, undefined, undefined);
}

// Namespace namespace_8f77dbcb
// Params 0, eflags: 0x0
// Checksum 0xcf13c96e, Offset: 0x2f0
// Size: 0xc4
function __init__() {
    level._effect["tesla_zombie_shock"] = "dlc4/genesis/fx_elec_trap_body_shock";
    if (ai::shouldregisterclientfieldforarchetype("mechz")) {
        clientfield::register("actor", "death_ray_shock_fx", 15000, 1, "int", &function_3852b0a4, 0, 0);
    }
    clientfield::register("actor", "mechz_fx_spawn", 15000, 1, "counter", &function_4b9cfd4c, 0, 0);
}

// Namespace namespace_8f77dbcb
// Params 7, eflags: 0x0
// Checksum 0x6328da43, Offset: 0x3c0
// Size: 0x124
function function_3852b0a4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self function_51adc559(localclientnum);
    if (newval) {
        if (!isdefined(self.var_8f44671e)) {
            tag = "J_SpineUpper";
            if (!self isai()) {
                tag = "tag_origin";
            }
            self.var_8f44671e = playfxontag(localclientnum, level._effect["tesla_zombie_shock"], self, tag);
            self playsound(0, "zmb_electrocute_zombie");
        }
        if (isdemoplaying()) {
            self thread function_7772592b(localclientnum);
        }
    }
}

// Namespace namespace_8f77dbcb
// Params 1, eflags: 0x0
// Checksum 0xf53bc5ba, Offset: 0x4f0
// Size: 0x4c
function function_7772592b(localclientnum) {
    self notify(#"hash_51adc559");
    self endon(#"hash_51adc559");
    level waittill(#"demo_jump");
    self function_51adc559(localclientnum);
}

// Namespace namespace_8f77dbcb
// Params 1, eflags: 0x0
// Checksum 0xb537c374, Offset: 0x548
// Size: 0x52
function function_51adc559(localclientnum) {
    if (isdefined(self.var_8f44671e)) {
        deletefx(localclientnum, self.var_8f44671e, 1);
        self.var_8f44671e = undefined;
    }
    self notify(#"hash_51adc559");
}

// Namespace namespace_8f77dbcb
// Params 7, eflags: 0x0
// Checksum 0xedc769c0, Offset: 0x5a8
// Size: 0xa4
function function_4b9cfd4c(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (newvalue) {
        self.spawnfx = playfxontag(localclientnum, level._effect["mechz_ground_spawn"], self, "tag_origin");
        playsound(0, "zmb_mechz_spawn_nofly", self.origin);
    }
}

